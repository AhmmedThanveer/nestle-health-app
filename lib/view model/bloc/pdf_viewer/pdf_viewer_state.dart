import 'package:equatable/equatable.dart';

abstract class PdfViewerState extends Equatable {
  const PdfViewerState();
}

class PdfViewerLoadingState extends PdfViewerState {
  const PdfViewerLoadingState();

  @override
  List<Object> get props => [];
}

class PdfViewerErrorState extends PdfViewerState {
  final String message;

  const PdfViewerErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class PdfViewerLoadedState extends PdfViewerState {
  /// Absolute path to the locally cached PDF file.
  final String localPath;

  /// 1-indexed current page (for display: "Page 2 of 10").
  final int currentPage;

  final int totalPages;

  const PdfViewerLoadedState({
    required this.localPath,
    this.currentPage = 1,
    this.totalPages = 0,
  });

  PdfViewerLoadedState copyWith({int? currentPage, int? totalPages}) =>
      PdfViewerLoadedState(
        localPath: localPath,
        currentPage: currentPage ?? this.currentPage,
        totalPages: totalPages ?? this.totalPages,
      );

  @override
  List<Object> get props => [localPath, currentPage, totalPages];
}
