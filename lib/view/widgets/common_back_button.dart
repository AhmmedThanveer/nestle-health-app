import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

class CommonBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const CommonBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: 48.w,
        height: 48.h,

        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),

          shape: BoxShape.circle,
        ),

        child: Icon(CupertinoIcons.back, color: AppColors.white, size: 22.sp),
      ),
    );
  }
}
