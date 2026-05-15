import 'package:equatable/equatable.dart';

class RegistrationEntity extends Equatable {
  final String id;
  final String userId;
  final String eventId;
  final String status;
  final DateTime registeredAt;

  const RegistrationEntity({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.status,
    required this.registeredAt,
  });

  @override
  List<Object?> get props => [id, userId, eventId, status];
}
