import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'pdf_viewer_event.dart';
import 'pdf_viewer_state.dart';

class PdfViewerBloc extends Bloc<PdfViewerEvent, PdfViewerState> {
  PdfViewerBloc() : super(const PdfViewerLoadingState()) {
    on<LoadPdfEvent>(_onLoad);
    on<PdfRenderedEvent>(_onRendered);
    on<PdfPageChangedEvent>(_onPageChanged);
  }

  Future<void> _onLoad(
    LoadPdfEvent event,
    Emitter<PdfViewerState> emit,
  ) async {
    emit(const PdfViewerLoadingState());
    try {
      final dir = await getTemporaryDirectory();
      final localFile = File('${dir.path}/${event.file.localFileName}');

      // If cached file exists but is not a real PDF (e.g. previously saved HTML
      // from Google Drive warning page), delete it so we re-download.
      if (await localFile.exists() && !await _isValidPdf(localFile)) {
        await localFile.delete();
      }

      if (!await localFile.exists()) {
        final url = _resolveUrl(event.file.pdfUrl);

        final dio = Dio(BaseOptions(
          followRedirects: true,
          maxRedirects: 5,
          receiveTimeout: const Duration(seconds: 60),
          connectTimeout: const Duration(seconds: 15),
          headers: {
            'User-Agent':
                'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 Chrome/120',
          },
        ));

        await dio.download(url, localFile.path);

        // Validate the downloaded file — if Google returned an HTML page
        // (login redirect or virus-scan warning), reject it.
        if (!await _isValidPdf(localFile)) {
          await localFile.delete();
          emit(const PdfViewerErrorState(
            'Cannot access this PDF.\n'
            'Make sure the Google Drive file sharing is set to\n'
            '"Anyone with the link can view".',
          ));
          return;
        }
      }

      emit(PdfViewerLoadedState(localPath: localFile.path));
    } on DioException catch (e) {
      emit(PdfViewerErrorState(
        e.type == DioExceptionType.connectionTimeout ||
                e.type == DioExceptionType.receiveTimeout
            ? 'Download timed out. Check your connection.'
            : 'Failed to download PDF. ${e.message ?? ''}',
      ));
    } catch (_) {
      emit(const PdfViewerErrorState(
        'Failed to load PDF. Please check your connection.',
      ));
    }
  }

  /// Returns true only if the file starts with the PDF magic bytes `%PDF`.
  Future<bool> _isValidPdf(File file) async {
    try {
      final bytes = await file
          .openRead(0, 4)
          .fold<List<int>>([], (acc, chunk) => acc..addAll(chunk));
      return bytes.length >= 4 &&
          bytes[0] == 0x25 && // %
          bytes[1] == 0x50 && // P
          bytes[2] == 0x44 && // D
          bytes[3] == 0x46; //  F
    } catch (_) {
      return false;
    }
  }

  /// Converts any Google Drive URL to a direct-download URL that bypasses
  /// the virus-scan confirmation page.
  String _resolveUrl(String url) {
    String? fileId;

    // Share link: https://drive.google.com/file/d/FILE_ID/view?...
    final shareMatch =
        RegExp(r'drive\.google\.com/file/d/([^/?]+)').firstMatch(url);
    if (shareMatch != null) fileId = shareMatch.group(1);

    // Direct link: https://drive.google.com/uc?export=download&id=FILE_ID
    if (fileId == null && url.contains('drive.google.com')) {
      final idMatch = RegExp(r'[?&]id=([^&]+)').firstMatch(url);
      if (idMatch != null) fileId = idMatch.group(1);
    }

    if (fileId != null) {
      // drive.usercontent.google.com serves the file directly without
      // the virus-scan warning page that uc?export=download sometimes shows.
      return 'https://drive.usercontent.google.com/u/0/uc'
          '?id=$fileId&export=download';
    }

    return url;
  }

  void _onRendered(PdfRenderedEvent event, Emitter<PdfViewerState> emit) {
    if (state is PdfViewerLoadedState) {
      emit((state as PdfViewerLoadedState)
          .copyWith(totalPages: event.totalPages));
    }
  }

  void _onPageChanged(PdfPageChangedEvent event, Emitter<PdfViewerState> emit) {
    if (state is PdfViewerLoadedState) {
      emit(
        (state as PdfViewerLoadedState).copyWith(
          currentPage: event.page + 1,
          totalPages: event.total > 0 ? event.total : null,
        ),
      );
    }
  }
}
