import 'package:equatable/equatable.dart';

class NsmWaveEntity extends Equatable {
  final String id;
  final String title;
  final String time;
  final int capacity;
  final int registered;
  final bool isFull;
  final int sortOrder;

  const NsmWaveEntity({
    required this.id,
    required this.title,
    required this.time,
    required this.capacity,
    required this.registered,
    required this.isFull,
    required this.sortOrder,
  });

  String get capacityLabel => '$registered/$capacity Full';

  @override
  List<Object?> get props =>
      [id, title, time, capacity, registered, isFull, sortOrder];
}

class NsmDayEntity extends Equatable {
  final String id;
  final int dayNumber;
  final String date;
  final List<NsmWaveEntity> waves;
  final int sortOrder;

  const NsmDayEntity({
    required this.id,
    required this.dayNumber,
    required this.date,
    required this.waves,
    required this.sortOrder,
  });

  @override
  List<Object?> get props => [id, dayNumber, date, waves, sortOrder];
}
