import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  final String id;
  final String code;
  final String name;
  final String? description;
  final bool isActive;
  final DateTime? startDate;
  final DateTime? endDate;

  const EventEntity({
    required this.id,
    required this.code,
    required this.name,
    this.description,
    required this.isActive,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [id, code, name, isActive];
}
