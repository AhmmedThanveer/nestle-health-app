import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_congress/core/constants/app_strings.dart';
import 'package:health_congress/core/theme/app_textstyles.dart';

class NestleLogoWidget extends StatelessWidget {
  /// Override the top gap. Defaults to 50.h (home / profile screens).
  /// Pass 0 or a small value for module screens that already have an app bar.
  final double? topPadding;

  const NestleLogoWidget({super.key, this.topPadding});

  // 150 ms silence + 480 ms animation = 630 ms total
  static const double _staggerFraction = 150 / 630;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 630),
      builder: (_, rawValue, cachedChild) {
        final double t =
            ((rawValue - _staggerFraction) / (1.0 - _staggerFraction))
                .clamp(0.0, 1.0);
        final double eased = Curves.easeOutCubic.transform(t);
        return Opacity(
          opacity: eased,
          child: FractionalTranslation(
            // RTL — slides in from right
            translation: Offset((1 - eased) * 0.12, 0),
            child: cachedChild,
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(height: topPadding ?? 50.h),

          Text(
            AppStrings.appTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.logoTitle,
          ),

          SizedBox(height: 8.h),

          Text(
            AppStrings.subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.logoSubtitle,
          ),
        ],
      ),
    );
  }
}
