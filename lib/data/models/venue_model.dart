import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/venue_entity.dart';

class VenueModel extends VenueEntity {
  const VenueModel({
    required super.name,
    required super.address,
    required super.city,
    required super.auditorium,
    required super.imageUrl,
    required super.latitude,
    required super.longitude,
  });

  factory VenueModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return VenueModel(
      name: d['name'] as String? ?? '',
      address: d['address'] as String? ?? '',
      city: d['city'] as String? ?? '',
      auditorium: d['auditorium'] as String? ?? '',
      imageUrl: d['imageUrl'] as String? ?? '',
      latitude: (d['latitude'] as num? ?? 0).toDouble(),
      longitude: (d['longitude'] as num? ?? 0).toDouble(),
    );
  }
}
