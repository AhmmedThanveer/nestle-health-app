import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../view%20model/bloc/media/media_bloc.dart';
import '../../../view%20model/bloc/media/media_state.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../widgets/bottom_nav/nestle_bottom_navigation_bar.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';
import 'widgets/media_grid_widget.dart';
import 'widgets/media_tabs_widget.dart';

class PhotosVideosScreen extends StatelessWidget {
  const PhotosVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MediaBloc(),
      child: const _PhotosVideosView(),
    );
  }
}

// ─── View ─────────────────────────────────────────────────────────────────────

class _PhotosVideosView extends StatelessWidget {
  const _PhotosVideosView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listenWhen: (prev, curr) => prev.currentIndex != curr.currentIndex,
      listener: (_, __) => Navigator.maybePop(context),
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.primaryBlue,
        bottomNavigationBar: const NestleBottomNavigationBar(),
        body: Stack(
          children: [
            // ── Background ──────────────────────────────────────
            Positioned.fill(
              child: Image.asset(
                AppImages.loginBg,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
                filterQuality: FilterQuality.low,
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.35, 0.62, 1.0],
                    colors: [
                      AppColors.primaryBlue.withValues(alpha: 1.0),
                      AppColors.primaryBlue.withValues(alpha: 0.95),
                      AppColors.primaryBlue.withValues(alpha: 0.75),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // ── Content ─────────────────────────────────────────
            SafeArea(
              bottom: false,
              child: BlocBuilder<MediaBloc, MediaState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ModuleAppBar(title: AppStrings.photosAndVideosTitle),
                      SizedBox(height: 4.h),

                      NestleLogoWidget(topPadding: 0),
                      SizedBox(height: 20.h),

                      MediaTabsWidget(state: state),
                      SizedBox(height: 16.h),

                      Expanded(
                        child: RepaintBoundary(
                          child: MediaGridWidget(state: state),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
