import 'package:equatable/equatable.dart';

class StationEntity extends Equatable {
  final String id;
  final String name;

  /// The exact string encoded in the physical QR code at this station.
  final String qrCode;
  final int points;

  const StationEntity({
    required this.id,
    required this.name,
    required this.qrCode,
    required this.points,
  });

  @override
  List<Object?> get props => [id, name, qrCode, points];
}
