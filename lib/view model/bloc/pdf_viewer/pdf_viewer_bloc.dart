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

      if (!await localFile.exists()) {
        final url = _resolveUrl(event.file.pdfUrl);

        final dio = Dio(BaseOptions(
          followRedirects: true,
          maxRedirects: 5,
          receiveTimeout: const Duration(seconds: 30),
          connectTimeout: const Duration(seconds: 15),
          headers: {
            'User-Agent':
                'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 Chrome/120',
          },
        ));

        final response = await dio.download(
          url,
          localFile.path,
          onReceiveProgress: (_, __) {},
        );

        // Google Drive returns HTML (warning page) instead of PDF for some files.
        // Detect this and delete the corrupted file.
        final contentType =
            response.headers.value(Headers.contentTypeHeader) ?? '';
        if (contentType.contains('text/html')) {
          await localFile.delete();
          emit(const PdfViewerErrorState(
            'Cannot access this PDF.\n'
            'Make sure the Google Drive file is shared as\n'
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

  /// Converts any Google Drive URL to a direct-download URL via
  /// drive.usercontent.google.com, which bypasses the virus-scan warning page.
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
      return 'https://drive.usercontent.google.com/u/0/uc?id=$fileId&export=download';
    }

    return url;
  }

  void _onRendered(PdfRenderedEvent event, Emitter<PdfViewerState> emit) {
    if (state is PdfViewerLoadedState) {
      emit((state as PdfViewerLoadedState).copyWith(totalPages: event.totalPages));
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
