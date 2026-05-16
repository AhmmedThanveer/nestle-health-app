import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/theme/app_textstyles.dart';

/// Reusable app-bar row for every module/detail screen.
///
/// Displays a circular back button on the left and a [title] to its right.
/// Uses [Navigator.maybePop] unless a custom [onBack] callback is provided.
class ModuleAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const ModuleAppBar({super.key, required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Row(
        children: [
          // Circular back button
          GestureDetector(
            onTap: onBack ?? () => Navigator.maybePop(context),
            child: Container(
              width: 45.r,
              height: 45.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightBlue.withValues(alpha: 0.35),
              ),
              child: Icon(
                Icons.chevron_left_rounded,
                color: AppColors.white,
                size: 35.r,
              ),
            ),
          ),
          SizedBox(width: 22.w),
          Text(title, style: AppTextStyles.moduleScreenTitle),
        ],
      ),
    );
  }
}
