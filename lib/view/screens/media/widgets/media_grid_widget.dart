import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/models/media_models.dart';
import '../../../../core/theme/app_textstyles.dart';
import '../../../../view%20model/bloc/media/media_state.dart';
import '../photo_viewer_screen.dart';
import '../video_player_screen.dart';

/// 2-column grid of photo and video cards.
class MediaGridWidget extends StatelessWidget {
  final MediaState state;

  const MediaGridWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final items = state.items;
    final double bottomPad = 80.h + MediaQuery.of(context).padding.bottom;

    return GridView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, bottomPad),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => _MediaCard(item: items[index]),
    );
  }
}

// ─── Single media card ────────────────────────────────────────────────────────

class _MediaCard extends StatelessWidget {
  final MediaItem item;

  const _MediaCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Background / thumbnail ────────────────────────
            if (item.type == MediaType.photo && item.thumbnailAsset != null)
              Image.asset(item.thumbnailAsset!, fit: BoxFit.cover)
            else
              Container(color: AppColors.videoCardBg),

            // ── Video: centered camera icon ───────────────────
            if (item.type == MediaType.video)
              Center(
                child: Container(
                  padding: EdgeInsets.all(14.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.18),
                  ),
                  child: Icon(
                    Icons.videocam_outlined,
                    color: AppColors.white,
                    size: 36.r,
                  ),
                ),
              ),

            // ── Bottom action bar ─────────────────────────────
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: AppColors.mediaPlayBarBg,
                padding: EdgeInsets.symmetric(vertical: 9.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.type == MediaType.photo
                          ? Icons.remove_red_eye_outlined
                          : Icons.play_arrow_rounded,
                      color: AppColors.white,
                      size: 16.r,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      item.type == MediaType.photo
                          ? AppStrings.mediaView
                          : AppStrings.play,
                      style: AppTextStyles.mediaCardAction,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    if (item.type == MediaType.photo && item.thumbnailAsset != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PhotoViewerScreen(
            assetPath: item.thumbnailAsset!,
            title: item.title,
          ),
        ),
      );
    } else if (item.type == MediaType.video && item.videoUrl != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoPlayerScreen(
            videoUrl: item.videoUrl!,
            title: item.title,
          ),
        ),
      );
    }
  }
}
