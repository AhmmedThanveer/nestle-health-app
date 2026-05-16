import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class HomeLoadingPlaceholder extends StatelessWidget {
  const HomeLoadingPlaceholder({super.key});

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
