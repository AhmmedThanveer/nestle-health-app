import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_textstyles.dart';

/// Full-screen in-app video player powered by video_player + chewie.
///
/// StatefulWidget is used ONLY to hold [VideoPlayerController] and
/// [ChewieController] — no setState anywhere in this class.
/// Initialisation is handled via [FutureBuilder] so the loading indicator
/// displays without requiring a setState-triggered rebuild.
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
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );
    _initFuture = _videoController.initialize().then((_) {
      // ChewieController is created once the video controller is ready;
      // FutureBuilder triggers the rebuild — no setState needed.
      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: true,
        looping: false,
        aspectRatio: _videoController.value.aspectRatio,
        placeholder: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(widget.title, style: AppTextStyles.moduleScreenTitle),
        elevation: 0,
      ),
      body: SafeArea(
        child: FutureBuilder<void>(
          future: _initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError || _chewieController == null) {
                return const Center(
                  child: Text(
                    'Failed to load video.',
                    style: TextStyle(color: Colors.white70),
                  ),
                );
              }
              return Center(child: Chewie(controller: _chewieController!));
            }
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}
