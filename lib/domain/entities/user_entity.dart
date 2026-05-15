import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String firstName;
  final String familyName;
  final String email;
  final String mobile;
  final String profession;
  final String city;
  final String workplace;
  final String saudiCouncilNumber;
  final String? eventId;
  final String? selectedTopic;
  final String? fcmToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int points;
  final List<String> scannedStations;

  const UserEntity({
    required this.uid,
    required this.firstName,
    required this.familyName,
    required this.email,
    required this.mobile,
    required this.profession,
    required this.city,
    required this.workplace,
    required this.saudiCouncilNumber,
    this.eventId,
    this.selectedTopic,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.points = 0,
    this.scannedStations = const [],
  });

  String get fullName => '$firstName $familyName';

  UserEntity copyWith({
    String? uid,
    String? firstName,
    String? familyName,
    String? email,
    String? mobile,
    String? profession,
    String? city,
    String? workplace,
    String? saudiCouncilNumber,
    String? eventId,
    String? selectedTopic,
    String? fcmToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? points,
    List<String>? scannedStations,
  }) =>
      UserEntity(
        uid: uid ?? this.uid,
        firstName: firstName ?? this.firstName,
        familyName: familyName ?? this.familyName,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        profession: profession ?? this.profession,
        city: city ?? this.city,
        workplace: workplace ?? this.workplace,
        saudiCouncilNumber: saudiCouncilNumber ?? this.saudiCouncilNumber,
        eventId: eventId ?? this.eventId,
        selectedTopic: selectedTopic ?? this.selectedTopic,
        fcmToken: fcmToken ?? this.fcmToken,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        points: points ?? this.points,
        scannedStations: scannedStations ?? this.scannedStations,
      );

  @override
  List<Object?> get props => [
        uid,
        firstName,
        familyName,
        email,
        mobile,
        profession,
        city,
        workplace,
        saudiCouncilNumber,
        eventId,
        selectedTopic,
        fcmToken,
        points,
        scannedStations,
      ];
}
