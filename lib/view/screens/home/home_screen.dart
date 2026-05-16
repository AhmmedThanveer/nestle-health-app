import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_textstyles.dart';
import '../../../view model/bloc/home/home_bloc.dart';
import '../../../view model/bloc/navigation/navigation_bloc.dart';
import '../../widgets/nestle_logo_widget.dart';
import 'widgets/module_grid_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => HomeBloc(), child: const _HomeView());
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> with TickerProviderStateMixin {
  late final AnimationController _headerCtrl;
  late final Animation<double> _headerOpacity;
  late final Animation<Offset> _headerSlide;

  @override
  void initState() {
    super.initState();

    _headerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _headerOpacity = CurvedAnimation(
      parent: _headerCtrl,
      curve: Curves.easeOut,
    );

    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _headerCtrl, curve: Curves.easeOutCubic));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      /// PRELOAD BACKGROUND
      await precacheImage(const AssetImage(AppImages.loginBg), context);

      if (!mounted) return;

      _headerCtrl.forward();

      /// START HOME LOADING
      context.read<HomeBloc>().add(const HomeLoadEvent());
    });
  }

  @override
  void dispose() {
    _headerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Stack(
        children: [
          /// BACKGROUND
          const Positioned.fill(child: _Background()),

          /// GRADIENT
          const Positioned.fill(child: _GradientOverlay()),

          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// HEADER
                FadeTransition(
                  opacity: _headerOpacity,
                  child: SlideTransition(
                    position: _headerSlide,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 4.h,
                          ),
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

                /// CONTENT
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            // Grid enters tree only when loaded — card entrance
                            // animations provide the visual "fade in" effect.
                            if (state.isLoaded)
                              RepaintBoundary(
                                child: ModuleGridContainer(
                                  onModuleTap: (route) {
                                    Navigator.pushNamed(context, route);
                                  },
                                ),
                              ),

                            // Spinner fades out when loaded; never blocks taps.
                            IgnorePointer(
                              child: AnimatedOpacity(
                                opacity: state.isLoaded ? 0.0 : 1.0,
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeOut,
                                child: const _LoadingPlaceholder(),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// LOADER

class _LoadingPlaceholder extends StatelessWidget {
  const _LoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
        border: Border.all(color: AppColors.glassBorder, width: 1.2),
        color: AppColors.glassBg,
      ),
      child: Center(
        child: SizedBox(
          width: 38.r,
          height: 38.r,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: AppColors.cyan.withValues(alpha: 0.9),
          ),
        ),
      ),
    );
  }
}

/// BACKGROUND

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Image.asset(
        AppImages.loginBg,
        fit: BoxFit.cover,
        alignment: Alignment.bottomCenter,

        /// PERFORMANCE FIX
        filterQuality: FilterQuality.low,

        /// PREVENT IMAGE FLASH
        gaplessPlayback: true,
      ),
    );
  }
}

/// GRADIENT

class _GradientOverlay extends StatelessWidget {
  const _GradientOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.45, 0.75, 1.0],
            colors: [
              AppColors.primaryBlue.withValues(alpha: 0.96),

              AppColors.primaryBlue.withValues(alpha: 0.82),

              AppColors.primaryBlue.withValues(alpha: 0.52),

              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

/// BELL BUTTON

class _BellButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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

/// HEADER

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
