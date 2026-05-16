import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  const EventModel({
    required super.id,
    required super.code,
    required super.name,
    super.description,
    required super.isActive,
    super.startDate,
    super.endDate,
  });

  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>? ?? {};
    return EventModel(
      id: doc.id,
      code: d['code'] as String? ?? '',
      name: d['name'] as String? ?? '',
      description: d['description'] as String?,
      isActive: d['isActive'] as bool? ?? false,
      startDate: (d['startDate'] as Timestamp?)?.toDate(),
      endDate: (d['endDate'] as Timestamp?)?.toDate(),
    );
  }
}

