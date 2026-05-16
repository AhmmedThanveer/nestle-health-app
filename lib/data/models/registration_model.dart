import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/registration_entity.dart';

class RegistrationModel extends RegistrationEntity {
  const RegistrationModel({
    required super.id,
    required super.userId,
    required super.eventId,
    required super.status,
    required super.registeredAt,
  });

  factory RegistrationModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>? ?? {};
    return RegistrationModel(
      id: doc.id,
      userId: d['userId'] as String? ?? '',
      eventId: d['eventId'] as String? ?? '',
      status: d['status'] as String? ?? 'active',
      registeredAt:
          (d['registeredAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'eventId': eventId,
        'status': status,
        'registeredAt': FieldValue.serverTimestamp(),
      };
}

