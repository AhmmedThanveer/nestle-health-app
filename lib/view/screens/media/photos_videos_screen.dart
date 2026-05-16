import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../view%20model/bloc/media/media_bloc.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../widgets/bottom_nav/nestle_bottom_navigation_bar.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';
import '../../widgets/screen_state_widget.dart';
import 'widgets/media_grid_widget.dart';
import 'widgets/media_tabs_widget.dart';

class PhotosVideosScreen extends StatelessWidget {
  const PhotosVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MediaBloc()..add(const LoadMediaEvent()),
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

            SafeArea(
              bottom: false,
              child: BlocBuilder<MediaBloc, MediaState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ModuleAppBar(title: AppStrings.photosAndVideosTitle),
                      SizedBox(height: 4.h),
                      const NestleLogoWidget(topPadding: 0),
                      SizedBox(height: 20.h),

                      if (state.status == MediaStatus.loaded ||
                          state.status == MediaStatus.initial) ...[
                        MediaTabsWidget(state: state),
                        SizedBox(height: 16.h),
                      ],

                      Expanded(
                        child: switch (state.status) {
                          MediaStatus.initial ||
                          MediaStatus.loading =>
                            const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            ),
                          MediaStatus.noInternet =>
                            ScreenStateWidget.noInternet(
                              onRetry: () => context
                                  .read<MediaBloc>()
                                  .add(const LoadMediaEvent()),
                            ),
                          MediaStatus.serverError =>
                            ScreenStateWidget.serverError(
                              message: state.errorMessage,
                              onRetry: () => context
                                  .read<MediaBloc>()
                                  .add(const LoadMediaEvent()),
                            ),
                          MediaStatus.empty => ScreenStateWidget.empty(
                              title: 'No media yet',
                              subtitle:
                                  'Photos and videos will appear here after the event.',
                            ),
                          MediaStatus.loaded => RepaintBoundary(
                              child: MediaGridWidget(state: state),
                            ),
                        },
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
