import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_textstyles.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../widgets/nestle_logo_widget.dart';
import 'widgets/module_grid_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => const _HomeView();
}

// ─── View ─────────────────────────────────────────────────────────────────────

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> with TickerProviderStateMixin {
  // Header slides in from the top
  late final AnimationController _headerCtrl;
  late final Animation<double> _headerOpacity;
  late final Animation<Offset> _headerSlide;

  // Grid cross-fades from spinner → cards
  late final AnimationController _gridCtrl;
  late final Animation<double> _gridFade;

  @override
  void initState() {
    super.initState();

    _headerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 480),
    );
    _headerOpacity = CurvedAnimation(
      parent: _headerCtrl,
      curve: Curves.easeOut,
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.07),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headerCtrl,
      curve: Curves.easeOutCubic,
    ));

    // Grid fade: 700 ms smooth reveal over the spinner
    _gridCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _gridFade = CurvedAnimation(parent: _gridCtrl, curve: Curves.easeInOut);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _headerCtrl.forward();
      // Spinner shows for 600 ms, then smoothly fades out as grid fades in
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        _gridCtrl.forward();
      });
    });
  }

  @override
  void dispose() {
    _headerCtrl.dispose();
    _gridCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Stack(
        children: [
          // ── Static background ─────────────────────────────────────
          const Positioned.fill(child: _Background()),
          const Positioned.fill(child: _GradientOverlay()),

          // ── Animated content ──────────────────────────────────────
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header: bell + logo — slides down from top
                FadeTransition(
                  opacity: _headerOpacity,
                  child: SlideTransition(
                    position: _headerSlide,
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

                // Spinner cross-fades into the module grid
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Stack(
                      children: [
                        // Spinner fades OUT as grid fades in (opacity = 1 - gridFade)
                        FadeTransition(
                          opacity: ReverseAnimation(_gridFade),
                          child: const _LoadingPlaceholder(),
                        ),
                        // Grid fades IN (opacity = gridFade)
                        FadeTransition(
                          opacity: _gridFade,
                          child: ModuleGridContainer(
                            onModuleTap: (route) =>
                                Navigator.pushNamed(context, route),
                          ),
                        ),
                      ],
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

// ─── Loading placeholder ──────────────────────────────────────────────────────

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
          width: 36.r,
          height: 36.r,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: AppColors.cyan.withValues(alpha: 0.8),
          ),
        ),
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
      onTap: () =>
          context.read<NavigationBloc>().add(const NavigateToTabEvent(2)),
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
            Icon(Icons.notifications_outlined,
                color: Colors.white, size: 22.r),
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

// ─── Reusable section header ──────────────────────────────────────────────────

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
