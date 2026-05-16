import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/models/asset_models.dart';
import '../../../core/theme/app_textstyles.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../../view%20model/bloc/pdf_viewer/pdf_viewer_bloc.dart';
import '../../../view%20model/bloc/pdf_viewer/pdf_viewer_event.dart';
import '../../../view%20model/bloc/pdf_viewer/pdf_viewer_state.dart';
import '../../widgets/bottom_nav/nestle_bottom_navigation_bar.dart';

/// Entry-point: provides [PdfViewerBloc] and immediately fires [LoadPdfEvent].
class PdfViewerScreen extends StatelessWidget {
  final AssetFile file;

  const PdfViewerScreen({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PdfViewerBloc()..add(LoadPdfEvent(file: file)),
      child: _PdfViewerView(file: file),
    );
  }
}

// â”€â”€â”€ View â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// StatefulWidget is used ONLY to hold the PDFViewController lifecycle object
// (a native bridge controller). All UI state lives in PdfViewerBloc.
// There is no setState call anywhere in this class.

class _PdfViewerView extends StatefulWidget {
  final AssetFile file;

  const _PdfViewerView({required this.file});

  @override
  State<_PdfViewerView> createState() => _PdfViewerViewState();
}

class _PdfViewerViewState extends State<_PdfViewerView> {
  // Held as a plain field â€” mutated by the native PDFView callback without
  // setState, because it drives imperative page jumps, not widget rebuilds.
  PDFViewController? _controller;

  Future<void> _goToPrev() async {
    final s = context.read<PdfViewerBloc>().state;
    if (s is! PdfViewerLoadedState || s.currentPage <= 1) return;
    // currentPage is 1-indexed; PDFView.setPage is 0-indexed.
    await _controller?.setPage(s.currentPage - 2);
  }

  Future<void> _goToNext() async {
    final s = context.read<PdfViewerBloc>().state;
    if (s is! PdfViewerLoadedState || s.currentPage >= s.totalPages) return;
    await _controller?.setPage(s.currentPage); // 1-indexed current == next 0-indexed
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listenWhen: (prev, curr) => prev.currentIndex != curr.currentIndex,
      listener: (_, __) => Navigator.maybePop(context),
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.primaryBlue,
        bottomNavigationBar: const NestleBottomNavigationBar(),
        body: Column(
          children: [
            // Top bar rebuilds whenever page / total changes.
            BlocBuilder<PdfViewerBloc, PdfViewerState>(
              builder: (context, state) => _TopBar(
                currentPage:
                    state is PdfViewerLoadedState ? state.currentPage : 1,
                totalPages:
                    state is PdfViewerLoadedState ? state.totalPages : 0,
                onBack: () => Navigator.maybePop(context),
              ),
            ),

            // PDFView only rebuilds when localPath changes (loading â†’ loaded
            // transition). Page-change events must NOT recreate the widget â€”
            // that would reset the native view back to page 0.
            Expanded(
              child: BlocBuilder<PdfViewerBloc, PdfViewerState>(
                buildWhen: (prev, curr) {
                  // Skip rebuild if we're already in loaded state and only
                  // currentPage / totalPages changed (PDF handles its own
                  // page rendering natively).
                  if (prev is PdfViewerLoadedState &&
                      curr is PdfViewerLoadedState) {
                    return false;
                  }
                  return true;
                },
                builder: (context, state) => _buildContent(context, state),
              ),
            ),

            // Bottom nav rebuilds whenever page / total changes.
            BlocBuilder<PdfViewerBloc, PdfViewerState>(
              builder: (context, state) {
                final loaded = state is PdfViewerLoadedState;
                return _BottomNav(
                  currentPage: loaded ? state.currentPage : 1,
                  totalPages: loaded ? state.totalPages : 0,
                  onPrev: loaded ? _goToPrev : null,
                  onNext: loaded ? _goToNext : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PdfViewerState state) {
    if (state is PdfViewerLoadingState) {
      return _LoadingView();
    }
    if (state is PdfViewerErrorState) {
      return _ErrorView(message: state.message);
    }
    if (state is PdfViewerLoadedState) {
      return PDFView(
        filePath: state.localPath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        pageSnap: true,
        defaultPage: 0,
        fitPolicy: FitPolicy.BOTH,
        backgroundColor: Colors.white,
        onViewCreated: (ctrl) => _controller = ctrl,
        onRender: (pages) =>
            context.read<PdfViewerBloc>().add(PdfRenderedEvent(pages ?? 0)),
        onPageChanged: (page, total) => context
            .read<PdfViewerBloc>()
            .add(PdfPageChangedEvent(page ?? 0, total ?? 0)),
        onError: (_) {},
      );
    }
    return const SizedBox.shrink();
  }
}

// â”€â”€â”€ Loading placeholder â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBlue,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 16.h),
            Text(
              'Loading PDFâ€¦',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// â”€â”€â”€ Error placeholder â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBlue,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.sp,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
    );
  }
}

// â”€â”€â”€ Top bar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _TopBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onBack;

  const _TopBar({
    required this.currentPage,
    required this.totalPages,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    return Container(
      color: AppColors.primaryBlue,
      padding: EdgeInsets.fromLTRB(4.w, topPad + 6.h, 16.w, 12.h),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.chevron_left_rounded,
              color: AppColors.white,
              size: 28.r,
            ),
          ),
          Expanded(
            child: Text(
              totalPages > 0
                  ? '${AppStrings.page} $currentPage '
                      '${AppStrings.of} $totalPages'
                  : AppStrings.page,
              style: AppTextStyles.pdfViewerHeader,
            ),
          ),
          Container(
            width: 34.r,
            height: 34.r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                '$currentPage',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryBlue,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// â”€â”€â”€ Bottom pagination bar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _BottomNav extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Future<void> Function()? onPrev;
  final Future<void> Function()? onNext;

  const _BottomNav({
    required this.currentPage,
    required this.totalPages,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final bool canPrev = onPrev != null && currentPage > 1;
    final bool canNext = onNext != null && currentPage < totalPages;
    return Container(
      color: AppColors.primaryBlue,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: canPrev ? () => onPrev!() : null,
            icon: Icon(
              Icons.chevron_left_rounded,
              color: canPrev ? AppColors.white : Colors.white30,
              size: 30.r,
            ),
          ),
          Text(
            totalPages > 0 ? '$currentPage / $totalPages' : 'â€”',
            style: AppTextStyles.pdfViewerPageNav,
          ),
          IconButton(
            onPressed: canNext ? () => onNext!() : null,
            icon: Icon(
              Icons.chevron_right_rounded,
              color: canNext ? AppColors.white : Colors.white30,
              size: 30.r,
            ),
          ),
        ],
      ),
    );
  }
}

