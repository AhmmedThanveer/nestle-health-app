import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class HomeGradientOverlay extends StatelessWidget {
  const HomeGradientOverlay({super.key});

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
