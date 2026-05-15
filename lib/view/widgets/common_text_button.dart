import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

class CommonTextButton extends StatelessWidget {
  final String title;

  final VoidCallback onTap;

  const CommonTextButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Text(
        title,

        textAlign: TextAlign.center,

        style: TextStyle(
          fontSize: 18.sp,

          fontWeight: FontWeight.w400,

          color: AppColors.white,

          fontFamily: 'Roboto',

          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
