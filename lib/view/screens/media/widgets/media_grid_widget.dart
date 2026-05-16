import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/models/media_models.dart';
import '../../../../core/theme/app_textstyles.dart';
import '../../../../view%20model/bloc/media/media_state.dart';
import '../../../widgets/animated_entrance_item.dart';
import '../photo_viewer_screen.dart';
import '../video_player_screen.dart';
import '../youtube_player_screen.dart';

class MediaGridWidget extends StatelessWidget {
  final MediaState state;

  const MediaGridWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final items = state.items;
    final double bottomPad = 80.h + MediaQuery.of(context).padding.bottom;

    if (items.isEmpty) {
      return Center(
        child: Text(
          state.selectedType == MediaType.photo
              ? 'No photos yet'
              : 'No videos yet',
          style: TextStyle(color: Colors.white54, fontSize: 15.sp),
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, bottomPad),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => AnimatedEntranceItem(
        direction: EntranceDirection.rtl,
        index: index,
        child: _MediaCard(item: items[index]),
      ),
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
            // ── Thumbnail ─────────────────────────────────────
            if (item.url != null)
              Image.network(
                item.url!,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) =>
                    progress == null ? child : _placeholder(),
                errorBuilder: (_, __, ___) => _placeholder(),
              )
            else
              _placeholder(),

            // ── Video play icon overlay ────────────────────────
            if (item.type == MediaType.video)
              Center(
                child: Container(
                  padding: EdgeInsets.all(14.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withValues(alpha: 0.45),
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
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

  Widget _placeholder() => Container(color: AppColors.videoCardBg);

  static bool _isYouTubeUrl(String url) =>
      url.contains('youtube.com') ||
      url.contains('youtu.be') ||
      url.contains('img.youtube.com');

  void _onTap(BuildContext context) {
    if (item.type == MediaType.photo && item.url != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PhotoViewerScreen(
            imageUrl: item.url!,
            title: item.title,
          ),
        ),
      );
    } else if (item.type == MediaType.video) {
      final url = item.videoUrl ?? item.url;
      if (url == null) return;

      if (_isYouTubeUrl(url)) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => YoutubePlayerScreen(videoUrl: url, title: item.title),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoPlayerScreen(videoUrl: url, title: item.title),
          ),
        );
      }
    }
  }
}
