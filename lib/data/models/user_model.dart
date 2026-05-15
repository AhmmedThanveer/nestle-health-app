import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.firstName,
    required super.familyName,
    required super.email,
    required super.mobile,
    required super.profession,
    required super.city,
    required super.workplace,
    required super.saudiCouncilNumber,
    super.eventId,
    super.selectedTopic,
    super.fcmToken,
    super.createdAt,
    super.updatedAt,
    super.points,
    super.scannedStations,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      firstName: d['firstName'] as String? ?? '',
      familyName: d['familyName'] as String? ?? '',
      email: d['email'] as String? ?? '',
      mobile: d['mobile'] as String? ?? '',
      profession: d['profession'] as String? ?? '',
      city: d['city'] as String? ?? '',
      workplace: d['workplace'] as String? ?? '',
      saudiCouncilNumber: d['saudiCouncilNumber'] as String? ?? '',
      eventId: d['eventId'] as String?,
      selectedTopic: d['selectedTopic'] as String?,
      fcmToken: d['fcmToken'] as String?,
      createdAt: (d['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (d['updatedAt'] as Timestamp?)?.toDate(),
      points: (d['points'] as num? ?? 0).toInt(),
      scannedStations: List<String>.from(d['scannedStations'] ?? []),
    );
  }

  factory UserModel.fromEntity(UserEntity e) => UserModel(
        uid: e.uid,
        firstName: e.firstName,
        familyName: e.familyName,
        email: e.email,
        mobile: e.mobile,
        profession: e.profession,
        city: e.city,
        workplace: e.workplace,
        saudiCouncilNumber: e.saudiCouncilNumber,
        eventId: e.eventId,
        selectedTopic: e.selectedTopic,
        fcmToken: e.fcmToken,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
        points: e.points,
        scannedStations: e.scannedStations,
      );

  Map<String, dynamic> toFirestore() => {
        'firstName': firstName,
        'familyName': familyName,
        'email': email,
        'mobile': mobile,
        'profession': profession,
        'city': city,
        'workplace': workplace,
        'saudiCouncilNumber': saudiCouncilNumber,
        'eventId': eventId,
        'selectedTopic': selectedTopic,
        'fcmToken': fcmToken,
        'createdAt': createdAt != null
            ? Timestamp.fromDate(createdAt!)
            : FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
}
