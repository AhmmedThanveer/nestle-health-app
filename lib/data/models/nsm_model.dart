import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/nsm_entity.dart';

class NsmWaveModel extends NsmWaveEntity {
  const NsmWaveModel({
    required super.id,
    required super.title,
    required super.time,
    required super.capacity,
    required super.registered,
    required super.isFull,
    required super.sortOrder,
  });

  factory NsmWaveModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>? ?? {};
    return NsmWaveModel(
      id: doc.id,
      title: d['title'] as String? ?? '',
      time: d['time'] as String? ?? '',
      capacity: (d['capacity'] as num? ?? 0).toInt(),
      registered: (d['registered'] as num? ?? 0).toInt(),
      isFull: d['isFull'] as bool? ?? false,
      sortOrder: (d['sortOrder'] as num? ?? 0).toInt(),
    );
  }
}

class NsmDayModel extends NsmDayEntity {
  const NsmDayModel({
    required super.id,
    required super.dayNumber,
    required super.date,
    required super.waves,
    required super.sortOrder,
  });

  factory NsmDayModel.fromFirestore(
    DocumentSnapshot doc,
    List<NsmWaveModel> waves,
  ) {
    final d = doc.data() as Map<String, dynamic>? ?? {};
    return NsmDayModel(
      id: doc.id,
      dayNumber: (d['dayNumber'] as num? ?? 0).toInt(),
      date: d['date'] as String? ?? '',
      waves: waves,
      sortOrder: (d['sortOrder'] as num? ?? 0).toInt(),
    );
  }
}

