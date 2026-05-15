class Station {
  final String id;
  final String name;

  /// The exact string encoded in the physical QR code at this station.
  final String qrCode;

  final int points;

  const Station({
    required this.id,
    required this.name,
    required this.qrCode,
    this.points = 50,
  });
}

class StationsData {
  static const List<Station> stations = [
    Station(
      id: 'medical_nutrition',
      name: 'MEDICAL NUTRITION',
      qrCode: 'NESTLE_STATION_MEDICAL_NUTRITION_2026',
    ),
    Station(
      id: 'adult_nutrition',
      name: 'ADULT NUTRITION',
      qrCode: 'NESTLE_STATION_ADULT_NUTRITION_2026',
    ),
    Station(
      id: 'nestle_academy',
      name: 'NESTLÉ ACADEMY',
      qrCode: 'NESTLE_STATION_ACADEMY_2026',
    ),
    Station(
      id: 'rd_innovation',
      name: 'R & D INNOVATION',
      qrCode: 'NESTLE_STATION_RD_INNOVATION_2026',
    ),
    Station(
      id: 'nestle_saudi',
      name: 'NESTLÉ SAUDI',
      qrCode: 'NESTLE_STATION_SAUDI_2026',
    ),
  ];
}
