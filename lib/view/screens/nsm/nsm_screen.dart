import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../../view%20model/bloc/nsm/nsm_bloc.dart';
import '../../../view%20model/bloc/nsm/nsm_event.dart';
import '../../../view%20model/bloc/nsm/nsm_state.dart';
import '../../widgets/bottom_nav/nestle_bottom_navigation_bar.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';
import 'widgets/nsm_day_header_widget.dart';
import 'widgets/nsm_wave_card_widget.dart';

class NsmScreen extends StatelessWidget {
  const NsmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NsmBloc()..add(const LoadNsmEvent()),
      child: const _NsmView(),
    );
  }
}

// ─── View ─────────────────────────────────────────────────────────────────────

class _NsmView extends StatelessWidget {
  const _NsmView();

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
          fit: StackFit.expand,
          children: [
            // ── Background ──────────────────────────────────────
            Image.asset(
              AppImages.loginBg,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
              filterQuality: FilterQuality.low,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.35, 0.62, 1.0],
                  colors: [
                    AppColors.primaryBlue.withValues(alpha: 0.95),
                    AppColors.primaryBlue.withValues(alpha: 0.88),
                    AppColors.primaryBlue.withValues(alpha: 0.70),
                    AppColors.primaryBlue.withValues(alpha: 0.90),
                  ],
                ),
              ),
            ),

            // ── Content ─────────────────────────────────────────
            SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ModuleAppBar(title: AppStrings.nsmScreenTitle),
                  SizedBox(height: 4.h),
                  NestleLogoWidget(topPadding: 0),
                  SizedBox(height: 8.h),

                  Expanded(
                    child: BlocBuilder<NsmBloc, NsmState>(
                      builder: (context, state) {
                        if (state is NsmLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(color: Colors.white),
                          );
                        }

                        if (state is NsmErrorState) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.wifi_off_rounded,
                                    color: Colors.white54, size: 48.r),
                                SizedBox(height: 12.h),
                                Text(
                                  state.message,
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 14.sp),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16.h),
                                TextButton(
                                  onPressed: () => context
                                      .read<NsmBloc>()
                                      .add(const LoadNsmEvent()),
                                  child: Text('Retry',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.sp)),
                                ),
                              ],
                            ),
                          );
                        }

                        final loaded = state as NsmLoadedState;
                        return RepaintBoundary(
                          child: ListView.builder(
                            padding: EdgeInsets.only(bottom: 100.h),
                            itemCount: _itemCount(loaded),
                            itemBuilder: (_, i) => _buildItem(loaded, i),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Flattens days + waves into a single index list:
  // [dayHeader, wave, wave, ..., dayHeader, wave, wave, ...]
  int _itemCount(NsmLoadedState state) {
    return state.days.fold(0, (sum, d) => sum + 1 + d.waves.length);
  }

  Widget _buildItem(NsmLoadedState state, int index) {
    int cursor = 0;
    for (final day in state.days) {
      if (index == cursor) return NsmDayHeaderWidget(day: day);
      cursor++;
      for (final wave in day.waves) {
        if (index == cursor) return NsmWaveCardWidget(wave: wave);
        cursor++;
      }
    }
    return const SizedBox.shrink();
  }
}
