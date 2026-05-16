import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../widgets/module_app_bar.dart';

/// In-app YouTube player. Accepts a full YouTube URL, a video ID, or a
/// YouTube thumbnail URL (img.youtube.com/vi/ID/...).
class YoutubePlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String title;

  const YoutubePlayerScreen({
    super.key,
    required this.videoUrl,
    required this.title,
  });

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _extractId(widget.videoUrl),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
        forceHD: false,
        useHybridComposition: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Extracts video ID from any YouTube URL format:
  ///   youtu.be/ID
  ///   youtube.com/watch?v=ID
  ///   img.youtube.com/vi/ID/hqdefault.jpg  (thumbnail URL stored in Firestore)
  static String _extractId(String url) {
    final fromPlayer = YoutubePlayer.convertUrlToId(url);
    if (fromPlayer != null) return fromPlayer;

    final thumbMatch =
        RegExp(r'img\.youtube\.com/vi/([^/?]+)').firstMatch(url);
    if (thumbMatch != null) return thumbMatch.group(1)!;

    return url;
  }

  void _onBack() {
    _controller.pause();
    Navigator.maybePop(context);
  }

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
                ModuleAppBar(title: widget.title, onBack: _onBack),
                SizedBox(height: 16.h),

                // YouTube player (16:9 aspect ratio)
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressColors: ProgressBarColors(
                    playedColor: AppColors.primaryBlue,
                    handleColor: AppColors.primaryBlue,
                    bufferedColor: AppColors.lightBlue.withValues(alpha: 0.6),
                    backgroundColor: Colors.white24,
                  ),
                  progressIndicatorColor: AppColors.primaryBlue,
                  onReady: () => _controller.play(),
                ),

                SizedBox(height: 20.h),

                // Title below player
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
