import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class AuthOverlayWidget extends StatelessWidget {
  const AuthOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,

          end: Alignment.bottomCenter,

          colors: [
            AppColors.primaryBlue.withOpacity(0.94),

            AppColors.primaryBlue.withOpacity(0.82),

            AppColors.primaryBlue.withOpacity(0.45),

            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
