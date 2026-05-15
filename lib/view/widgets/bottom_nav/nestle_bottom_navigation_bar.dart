import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_svg_icons.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../app_svg_icon.dart';

class NestleBottomNavigationBar extends StatelessWidget {
  const NestleBottomNavigationBar({super.key});

  static const List<_NavItemData> _items = [
    _NavItemData(
      svgPath: AppSvgIcons.home,
      fallbackIcon: Icons.home_rounded,
      label: AppStrings.home,
    ),
    _NavItemData(
      svgPath: AppSvgIcons.liveChat,
      fallbackIcon: Icons.chat_bubble_rounded,
      label: AppStrings.liveChat,
    ),
    _NavItemData(
      svgPath: AppSvgIcons.notifications,
      fallbackIcon: Icons.notifications_rounded,
      label: AppStrings.notifications,
    ),
    _NavItemData(
      svgPath: AppSvgIcons.profile,
      fallbackIcon: Icons.person_rounded,
      label: AppStrings.profile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double bottomPad = MediaQuery.of(context).padding.bottom;

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Container(
          color: Colors.transparent,
          padding: EdgeInsets.fromLTRB(
            16.w,
            8.h,
            16.w,
            bottomPad > 0 ? bottomPad : 14.h,
          ),
          child: Container(
            // Outer glow — must live outside ClipRRect so it isn't clipped
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cyan.withValues(alpha: 0.45),
                  blurRadius: 18,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  height: 76.h,
                  decoration: BoxDecoration(
                    // Dark tint so background shows through but text stays legible
                    color: Colors.black.withValues(alpha: 0.30),
                    borderRadius: BorderRadius.circular(28.r),
                    border: Border.all(
                      color: AppColors.cyan.withValues(alpha: 0.80),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      _items.length,
                      (index) => _NavItem(
                        data: _items[index],
                        index: index,
                        currentIndex: state.currentIndex,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── Data holder ─────────────────────────────────────────────────────────────

class _NavItemData {
  final String svgPath;
  final IconData fallbackIcon;
  final String label;

  const _NavItemData({
    required this.svgPath,
    required this.fallbackIcon,
    required this.label,
  });
}

// ─── Single nav item ──────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  final _NavItemData data;
  final int index;
  final int currentIndex;

  const _NavItem({
    required this.data,
    required this.index,
    required this.currentIndex,
  });

  bool get _isSelected => index == currentIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.read<NavigationBloc>().add(NavigateToTabEvent(index)),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon — bigger & brighter when selected
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: AppSvgIcon(
                key: ValueKey('nav_${index}_$_isSelected'),
                assetPath: data.svgPath,
                fallbackIcon: data.fallbackIcon,
                size: _isSelected ? 34.r : 22.r,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 4.h),

            // Label — always shown, bold+larger when selected
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: _isSelected ? 11.5.sp : 10.sp,
                fontWeight:
                    _isSelected ? FontWeight.w700 : FontWeight.w400,
                color: Colors.white,
              ),
              child: Text(
                data.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
