import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/models/home_module_data.dart';
import '../../../core/theme/app_textstyles.dart';
import '../../../view%20model/bloc/home/home_bloc.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../widgets/nestle_logo_widget.dart';
import 'widgets/home_module_card.dart';

/// Provides [HomeBloc] locally so the screen owns its own lifecycle.
/// The bloc fires [HomeLoadEvent] immediately in `create`, triggering
/// entrance animations after a single frame-settle delay.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(const HomeLoadEvent()),
      child: const _HomeView(),
    );
  }
}

// ─── View layer – purely declarative, zero setState ───────────────────────────

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Stack(
        children: [
          /// Static background image – never rebuilds
          const Positioned.fill(child: _Background()),

          /// Static gradient overlay – never rebuilds
          const Positioned.fill(child: _GradientOverlay()),

          /// Animated content driven entirely by HomeBloc
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Header: slides down from above + fades in ──────
                    AnimatedOpacity(
                      opacity: state.isLoaded ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 420),
                      curve: Curves.easeOut,
                      child: AnimatedSlide(
                        offset: state.isLoaded
                            ? Offset.zero
                            : const Offset(0, -0.06),
                        duration: const Duration(milliseconds: 420),
                        curve: Curves.easeOutCubic,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 4.h),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: _BellButton(),
                              ),
                            ),
                            const NestleLogoWidget(),
                            SizedBox(height: 18.h),
                          ],
                        ),
                      ),
                    ),

                    // ── Grid container: slides up + fades in ───────────
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: AnimatedOpacity(
                          opacity: state.isLoaded ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 480),
                          curve: Curves.easeOut,
                          child: AnimatedSlide(
                            offset: state.isLoaded
                                ? Offset.zero
                                : const Offset(0, 0.07),
                            duration: const Duration(milliseconds: 480),
                            curve: Curves.easeOutQuart,
                            child: const _ModuleGridContainer(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─── Static background pieces ─────────────────────────────────────────────────

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Image.asset(
          AppImages.loginBg,
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}

class _GradientOverlay extends StatelessWidget {
  const _GradientOverlay();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.45, 0.75, 1.0],
          colors: [
            AppColors.primaryBlue.withValues(alpha: 0.95),
            AppColors.primaryBlue.withValues(alpha: 0.80),
            AppColors.primaryBlue.withValues(alpha: 0.50),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

// ─── Bell icon button ─────────────────────────────────────────────────────────

class _BellButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Notifications tab (index 2) via the global NavigationBloc
        context.read<NavigationBloc>().add(const NavigateToTabEvent(2));
      },
      child: Container(
        width: 42.r,
        height: 42.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.notifications_outlined, color: Colors.white, size: 22.r),
            Positioned(
              top: 8.r,
              right: 8.r,
              child: Container(
                width: 8.r,
                height: 8.r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cyan,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Glass grid container ─────────────────────────────────────────────────────

class _ModuleGridContainer extends StatelessWidget {
  const _ModuleGridContainer();

  @override
  Widget build(BuildContext context) {
    final double navBarOffset =
        92.h + MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
        border: Border.all(color: AppColors.glassBorder, width: 1.2),
        color: AppColors.glassBg,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
        child: GridView.builder(
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, navBarOffset),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 18.h,
            crossAxisSpacing: 8.w,
            childAspectRatio: 0.82,
          ),
          itemCount: HomeModuleData.all.length,
          itemBuilder: (context, index) {
            final module = HomeModuleData.all[index];
            return HomeModuleCard(
              data: module,
              index: index,
              onTap: () => Navigator.pushNamed(context, module.route),
            );
          },
        ),
      ),
    );
  }
}

// ─── Reusable section header for sub-screens ─────────────────────────────────

class HomeScreenHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const HomeScreenHeader({
    super.key,
    required this.title,
    this.subtitle = AppStrings.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: AppTextStyles.sectionTitle),
        SizedBox(height: 4.h),
        Text(subtitle, style: AppTextStyles.bodyWhite),
      ],
    );
  }
}
