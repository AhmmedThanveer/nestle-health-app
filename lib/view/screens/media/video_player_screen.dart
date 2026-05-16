import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../widgets/module_app_bar.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String title;

  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.title,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final VideoPlayerController _videoController;
  late final Future<void> _initFuture;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _initFuture = _videoController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: true,
        looping: false,
        aspectRatio: _videoController.value.aspectRatio,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.primaryBlue,
          handleColor: AppColors.primaryBlue,
          bufferedColor: AppColors.lightBlue,
        ),
      );
    });
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController.dispose();
    super.dispose();
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
                ModuleAppBar(title: widget.title),
                SizedBox(height: 16.h),

                Expanded(
                  child: FutureBuilder<void>(
                    future: _initFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }
                      if (snapshot.hasError || _chewieController == null) {
                        return Center(
                          child: Text(
                            'Failed to load video.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14.sp,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        );
                      }
                      return Center(
                        child: AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: Chewie(controller: _chewieController!),
                        ),
                      );
                    },
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
