import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_congress/core/theme/app_textstyles.dart';

import '../../core/constants/app_colors.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isLoading;

  const CommonButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 60.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isLoading
              ? AppColors.buttonPressedBg
              : AppColors.buttonNormalBg,
          borderRadius: BorderRadius.circular(12.r),
        ),
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? SizedBox(
                  key: const ValueKey('loading'),
                  width: 24.r,
                  height: 24.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              : Text(
                  key: const ValueKey('label'),
                  title,
                  style: AppTextStyles.buttonStyle,
                ),
        ),
      ),
    );
  }
}
