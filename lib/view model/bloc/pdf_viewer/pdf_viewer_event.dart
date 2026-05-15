import 'package:equatable/equatable.dart';

import '../../../core/models/asset_models.dart';

abstract class PdfViewerEvent extends Equatable {
  const PdfViewerEvent();
}

/// Triggers PDF download (or cache-hit) and emits [PdfViewerLoadedState].
class LoadPdfEvent extends PdfViewerEvent {
  final AssetFile file;

  const LoadPdfEvent({required this.file});

  @override
  List<Object> get props => [file.pdfUrl];
}

/// Fired by [PDFView.onRender] once the PDF is rendered — provides total pages.
class PdfRenderedEvent extends PdfViewerEvent {
  final int totalPages;

  const PdfRenderedEvent(this.totalPages);

  @override
  List<Object> get props => [totalPages];
}

/// Fired by [PDFView.onPageChanged] whenever the visible page changes.
class PdfPageChangedEvent extends PdfViewerEvent {
  /// 0-indexed page from the native PDF view.
  final int page;
  final int total;

  const PdfPageChangedEvent(this.page, this.total);

  @override
  List<Object> get props => [page, total];
}
