import 'package:equatable/equatable.dart';

class VenueEntity extends Equatable {
  final String name;
  final String address;
  final String city;
  final String auditorium;
  final String imageUrl;
  final double latitude;
  final double longitude;

  const VenueEntity({
    required this.name,
    required this.address,
    required this.city,
    required this.auditorium,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props =>
      [name, address, city, auditorium, imageUrl, latitude, longitude];
}
