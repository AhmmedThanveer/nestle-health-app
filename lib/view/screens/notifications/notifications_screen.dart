import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_textstyles.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.loginBg,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryBlue.withValues(alpha: 0.96),
                    AppColors.primaryBlue.withValues(alpha: 0.82),
                    AppColors.primaryBlue.withValues(alpha: 0.55),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0),
                  child: Text(
                    AppStrings.notifications,
                    style: AppTextStyles.sectionTitle,
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    'Session reminders & announcements',
                    style: AppTextStyles.bodyWhite,
                  ),
                ),
                SizedBox(height: 24.h),
                Expanded(child: _NotificationsPlaceholder()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationsPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.glassBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
        border: Border.all(color: AppColors.glassBorder, width: 1.2),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications_outlined,
              size: 64.r,
              color: AppColors.cyan,
            ),
            SizedBox(height: 16.h),
            Text('Notifications', style: AppTextStyles.sectionTitle),
            SizedBox(height: 8.h),
            Text(
              'Push notifications and live\nannouncements will appear here.',
              style: AppTextStyles.bodyWhite,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
