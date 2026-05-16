enum MediaType { photo, video }

class MediaItem {
  final String id;
  final String title;
  final MediaType type;
  final String? url;       // Firebase Storage URL (photo thumbnail or video)
  final String? videoUrl;  // separate stream URL when different from thumbnail
  final int order;

  const MediaItem({
    required this.id,
    required this.title,
    required this.type,
    this.url,
    this.videoUrl,
    this.order = 0,
  });

  factory MediaItem.fromFirestore(String id, Map<String, dynamic> data) {
    final typeStr = (data['type'] as String?) ?? 'photo';
    return MediaItem(
      id: id,
      title: (data['title'] as String?) ?? '',
      type: typeStr == 'video' ? MediaType.video : MediaType.photo,
      url: data['url'] as String?,
      videoUrl: data['videoUrl'] as String?,
      order: (data['order'] as num?)?.toInt() ?? 0,
    );
  }
}
