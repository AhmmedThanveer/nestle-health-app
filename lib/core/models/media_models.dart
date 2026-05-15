enum MediaType { photo, video }

class MediaItem {
  final String title;
  final MediaType type;

  // Local asset path for photos
  final String? thumbnailAsset;

  // YouTube or other video URL
  final String? videoUrl;

  const MediaItem({
    required this.title,
    required this.type,
    this.thumbnailAsset,
    this.videoUrl,
  });
}

class MediaData {
  static const List<MediaItem> items = [
    // ── Photos ───────────────────────────────────────────────────
    MediaItem(
      title: 'Opening Ceremony',
      type: MediaType.photo,
      thumbnailAsset: 'assets/images/bgimg.png',
    ),
    MediaItem(
      title: 'Keynote Session',
      type: MediaType.photo,
      thumbnailAsset: 'assets/images/bgimg.png',
    ),
    MediaItem(
      title: 'Workshop Day 1',
      type: MediaType.photo,
      thumbnailAsset: 'assets/images/bgimg.png',
    ),
    MediaItem(
      title: 'Networking Event',
      type: MediaType.photo,
      thumbnailAsset: 'assets/images/bgimg.png',
    ),

    // ── Videos (direct MP4 for in-app playback) ───────────────────
    MediaItem(
      title: 'Congress Highlights',
      type: MediaType.video,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    ),
    MediaItem(
      title: 'Keynote Address',
      type: MediaType.video,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    ),
    MediaItem(
      title: 'Panel Discussion',
      type: MediaType.video,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    ),
  ];

  static List<MediaItem> byType(MediaType type) =>
      items.where((m) => m.type == type).toList();
}
