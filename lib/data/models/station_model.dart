import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/station_entity.dart';

class StationModel extends StationEntity {
  const StationModel({
    required super.id,
    required super.name,
    required super.qrCode,
    required super.points,
  });

  factory StationModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return StationModel(
      id: doc.id,
      name: d['stationName'] as String? ?? '',
      qrCode: d['qrCode'] as String? ?? doc.id,
      points: (d['points'] as num? ?? 50).toInt(),
    );
  }
}
