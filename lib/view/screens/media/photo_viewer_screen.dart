import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';

/// Full-screen image viewer with pinch-to-zoom and a close button.
class PhotoViewerScreen extends StatelessWidget {
  final String assetPath;
  final String title;

  const PhotoViewerScreen({
    super.key,
    required this.assetPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── Zoomable image ────────────────────────────────────
          Center(
            child: InteractiveViewer(
              minScale: 0.8,
              maxScale: 4.0,
              child: Image.asset(assetPath, fit: BoxFit.contain),
            ),
          ),

          // ── Close button ──────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(12.r),
              child: GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightBlue.withValues(alpha: 0.35),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: AppColors.white,
                    size: 22.r,
                  ),
                ),
              ),
            ),
          ),

          // ── Title overlay ─────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              color: Colors.black54,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
