import 'package:equatable/equatable.dart';

import '../../../domain/entities/station_entity.dart';

enum StationsStatus { initial, loading, loaded, scanning, error }
enum ScanResult { none, success, failure, alreadyScanned }

class StationsState extends Equatable {
  final StationsStatus status;
  final List<StationEntity> stations;
  final List<String> scannedStationIds;
  final ScanResult scanResult;
  final StationEntity? lastScannedStation;
  final int sessionPoints;
  final String? errorMessage;

  const StationsState({
    this.status = StationsStatus.initial,
    this.stations = const [],
    this.scannedStationIds = const [],
    this.scanResult = ScanResult.none,
    this.lastScannedStation,
    this.sessionPoints = 0,
    this.errorMessage,
  });

  bool isScanned(String stationId) => scannedStationIds.contains(stationId);

  StationsState copyWith({
    StationsStatus? status,
    List<StationEntity>? stations,
    List<String>? scannedStationIds,
    ScanResult? scanResult,
    StationEntity? lastScannedStation,
    bool clearLastStation = false,
    int? sessionPoints,
    String? errorMessage,
  }) =>
      StationsState(
        status: status ?? this.status,
        stations: stations ?? this.stations,
        scannedStationIds: scannedStationIds ?? this.scannedStationIds,
        scanResult: scanResult ?? this.scanResult,
        lastScannedStation:
            clearLastStation ? null : (lastScannedStation ?? this.lastScannedStation),
        sessionPoints: sessionPoints ?? this.sessionPoints,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [
        status,
        stations,
        scannedStationIds,
        scanResult,
        lastScannedStation,
        sessionPoints,
        errorMessage,
      ];
}
