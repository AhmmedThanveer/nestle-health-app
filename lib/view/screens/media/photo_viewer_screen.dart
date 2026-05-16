import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../widgets/module_app_bar.dart';

/// Full-screen image viewer — accepts either a network URL (imageUrl)
/// or a local asset path (assetPath). Pass exactly one.
class PhotoViewerScreen extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final String? assetPath;

  const PhotoViewerScreen({
    super.key,
    required this.title,
    this.imageUrl,
    this.assetPath,
  }) : assert(imageUrl != null || assetPath != null,
            'Provide either imageUrl or assetPath');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.primaryBlue,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background image ──────────────────────────────────
          Image.asset(
            AppImages.loginBg,
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
            filterQuality: FilterQuality.low,
          ),

          // ── Gradient overlay ──────────────────────────────────
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.35, 0.62, 1.0],
                colors: [
                  AppColors.primaryBlue.withValues(alpha: 1.0),
                  AppColors.primaryBlue.withValues(alpha: 0.95),
                  AppColors.primaryBlue.withValues(alpha: 0.75),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // ── Content ───────────────────────────────────────────
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ModuleAppBar(title: title),
                SizedBox(height: 8.h),

                Expanded(
                  child: InteractiveViewer(
                    minScale: 0.8,
                    maxScale: 4.0,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: imageUrl != null
                              ? Image.network(
                                  imageUrl!,
                                  fit: BoxFit.contain,
                                  loadingBuilder: (_, child, progress) {
                                    if (progress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.white),
                                    );
                                  },
                                  errorBuilder: (_, __, ___) => Icon(
                                    Icons.broken_image_outlined,
                                    color: Colors.white38,
                                    size: 64.r,
                                  ),
                                )
                              : Image.asset(assetPath!, fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
