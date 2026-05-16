import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/models/speaker_models.dart';

class SpeakerModel extends Speaker {
  const SpeakerModel({
    required super.name,
    required super.bio,
    required super.imageUrl,
    required super.category,
  });

  factory SpeakerModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>? ?? {};
    return SpeakerModel(
      name: d['name'] as String? ?? '',
      bio: d['bio'] as String? ?? '',
      imageUrl: d['imageUrl'] as String? ?? '',
      category: _parseCategory(d['category'] as String? ?? ''),
    );
  }

  static SpeakerCategory _parseCategory(String raw) => switch (raw) {
        'speakers' => SpeakerCategory.speakers,
        'nestleSpeakers' => SpeakerCategory.nestleSpeakers,
        _ => SpeakerCategory.chairpersons,
      };

  Map<String, dynamic> toFirestore(String eventId, int order) => {
        'name': name,
        'bio': bio,
        'imageUrl': imageUrl,
        'category': _categoryToString(category),
        'eventId': eventId,
        'order': order,
      };

  static String _categoryToString(SpeakerCategory c) => switch (c) {
        SpeakerCategory.speakers => 'speakers',
        SpeakerCategory.nestleSpeakers => 'nestleSpeakers',
        SpeakerCategory.chairpersons => 'chairpersons',
      };
}

