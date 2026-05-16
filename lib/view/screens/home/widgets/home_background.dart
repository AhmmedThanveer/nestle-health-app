import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Image.asset(
        AppImages.loginBg,
        fit: BoxFit.cover,
        alignment: Alignment.bottomCenter,
        filterQuality: FilterQuality.low,
        gaplessPlayback: true,
      ),
    );
  }
}
