import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

enum ScreenStateType { noInternet, empty, serverError }

class ScreenStateWidget extends StatelessWidget {
  final ScreenStateType type;
  final String? title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const ScreenStateWidget({
    super.key,
    required this.type,
    this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  factory ScreenStateWidget.noInternet({VoidCallback? onRetry}) =>
      ScreenStateWidget(
        type: ScreenStateType.noInternet,
        title: 'No internet connection',
        subtitle: 'Check your connection and try again.',
        actionLabel: 'Retry',
        onAction: onRetry,
      );

  factory ScreenStateWidget.empty({
    String title = 'Nothing here yet',
    String subtitle = '',
    String actionLabel = 'Refresh',
    VoidCallback? onAction,
  }) =>
      ScreenStateWidget(
        type: ScreenStateType.empty,
        title: title,
        subtitle: subtitle,
        actionLabel: actionLabel,
        onAction: onAction,
      );

  factory ScreenStateWidget.serverError({
    String? message,
    VoidCallback? onRetry,
  }) =>
      ScreenStateWidget(
        type: ScreenStateType.serverError,
        title: 'Something went wrong',
        subtitle: message ?? 'An unexpected error occurred. Please try again.',
        actionLabel: 'Retry',
        onAction: onRetry,
      );

  @override
  Widget build(BuildContext context) {
    final IconData icon = switch (type) {
      ScreenStateType.noInternet => Icons.wifi_off_rounded,
      ScreenStateType.empty => Icons.inbox_rounded,
      ScreenStateType.serverError => Icons.error_outline_rounded,
    };

    final Color iconColor = switch (type) {
      ScreenStateType.noInternet => Colors.white54,
      ScreenStateType.empty => Colors.white38,
      ScreenStateType.serverError => Colors.redAccent.withValues(alpha: 0.8),
    };

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
              child: Icon(icon, color: iconColor, size: 38.r),
            ),
            SizedBox(height: 20.h),
            if (title != null)
              Text(
                title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            if (subtitle != null && subtitle!.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13.sp,
                  color: Colors.white60,
                  height: 1.5,
                ),
              ),
            ],
            if (onAction != null) ...[
              SizedBox(height: 28.h),
              GestureDetector(
                onTap: onAction,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    actionLabel ?? 'Retry',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
