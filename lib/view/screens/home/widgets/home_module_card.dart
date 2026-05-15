import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/home_module_data.dart';
import '../../../../core/theme/app_textstyles.dart';
import '../../../widgets/app_svg_icon.dart';

class HomeModuleCard extends StatefulWidget {
  final HomeModuleData data;
  final int index;
  final VoidCallback onTap;

  const HomeModuleCard({
    super.key,
    required this.data,
    required this.index,
    required this.onTap,
  });

  @override
  State<HomeModuleCard> createState() => _HomeModuleCardState();
}

class _HomeModuleCardState extends State<HomeModuleCard>
    with TickerProviderStateMixin {
  // ── Entrance animation ───────────────────────────────────────────────────
  late final AnimationController _entranceCtrl;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  late final Animation<double> _scale;

  // ── Press animation ──────────────────────────────────────────────────────
  late final AnimationController _pressCtrl;
  late final Animation<double> _pressScale;

  @override
  void initState() {
    super.initState();

    // Entrance — 520 ms with easeOutBack so cards "pop" past 1.0 and settle
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.40),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.0, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _scale = Tween<double>(begin: 0.72, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceCtrl,
        // easeOutBack overshoots slightly → gives the "pop" bounce feel
        curve: const Interval(0.0, 0.85, curve: Curves.easeOutBack),
      ),
    );

    // Press — quick down, slower bounce back
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 90),
      reverseDuration: const Duration(milliseconds: 200),
    );

    _pressScale = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _pressCtrl, curve: Curves.easeOut),
    );

    // Stagger: each card starts 55 ms after the previous one
    Future.delayed(Duration(milliseconds: widget.index * 55), () {
      if (mounted) _entranceCtrl.forward();
    });
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    _pressCtrl.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _pressCtrl.forward();
  void _onTapUp(TapUpDetails _) {
    _pressCtrl.reverse();
    widget.onTap();
  }
  void _onTapCancel() => _pressCtrl.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: Listenable.merge([_entranceCtrl, _pressCtrl]),
        builder: (context, child) => FadeTransition(
          opacity: _opacity,
          child: SlideTransition(
            position: _slide,
            child: Transform.scale(
              scale: _scale.value * _pressScale.value,
              child: child,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CircleIcon(
              svgPath: widget.data.svgPath,
              fallbackIcon: widget.data.fallbackIcon,
            ),
            SizedBox(height: 8.h),
            Text(
              widget.data.label,
              style: AppTextStyles.moduleLabel,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Circular icon container ──────────────────────────────────────────────────

class _CircleIcon extends StatelessWidget {
  final String svgPath;
  final IconData fallbackIcon;

  const _CircleIcon({required this.svgPath, required this.fallbackIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68.r,
      height: 68.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.cyan, width: 1.8),
        gradient: RadialGradient(
          colors: [
            AppColors.cyan.withValues(alpha: 0.12),
            AppColors.primaryBlue.withValues(alpha: 0.05),
            Colors.transparent,
          ],
          stops: const [0.0, 0.6, 1.0],
          radius: 0.85,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyan.withValues(alpha: 0.18),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: AppSvgIcon(
          assetPath: svgPath,
          fallbackIcon: fallbackIcon,
          size: 28.r,
          color: Colors.white,
        ),
      ),
    );
  }
}
