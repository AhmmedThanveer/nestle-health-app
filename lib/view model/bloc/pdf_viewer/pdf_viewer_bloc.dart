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
        await Dio().download(event.file.pdfUrl, localFile.path);
      }

      emit(PdfViewerLoadedState(localPath: localFile.path));
    } catch (_) {
      emit(
        const PdfViewerErrorState(
          'Failed to load PDF. Please check your connection.',
        ),
      );
    }
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
          // PDFView reports 0-indexed pages; convert to 1-indexed for display.
          currentPage: event.page + 1,
          totalPages: event.total > 0 ? event.total : null,
        ),
      );
    }
  }
}
