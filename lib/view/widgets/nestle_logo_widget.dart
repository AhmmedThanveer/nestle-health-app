import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_congress/core/constants/app_strings.dart';
import 'package:health_congress/core/theme/app_textstyles.dart';

class NestleLogoWidget extends StatelessWidget {
  /// Override the top gap. Defaults to 50.h (home / profile screens).
  /// Pass 0 or a small value for module screens that already have an app bar.
  final double? topPadding;

  const NestleLogoWidget({super.key, this.topPadding});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: topPadding ?? 50.h),

        /// NESTLE CONGRESS
        Text(
          AppStrings.appTitle,

          textAlign: TextAlign.center,

          style: AppTextStyles.logoTitle,
        ),

        SizedBox(height: 8.h),

        /// THE NEXT ERA OF NUTRITION & HEALTH
        Text(
          AppStrings.subtitle,

          textAlign: TextAlign.center,

          style: AppTextStyles.logoSubtitle,
        ),
      ],
    );
  }
}
