import 'package:equatable/equatable.dart';

import '../../../core/models/station_models.dart';

enum ScanResult { none, success, failure }

abstract class StationsState extends Equatable {
  const StationsState();
}

class StationsLoadingState extends StationsState {
  const StationsLoadingState();

  @override
  List<Object> get props => [];
}

class StationsLoadedState extends StationsState {
  final List<Station> stations;

  /// IDs of stations that have already been successfully scanned this session.
  final List<String> scannedStationIds;

  /// Result of the most recent scan — reset to [ScanResult.none] after handling.
  final ScanResult scanResult;

  /// Running total of points accumulated across all scanned stations.
  final int totalPoints;

  const StationsLoadedState({
    required this.stations,
    this.scannedStationIds = const [],
    this.scanResult = ScanResult.none,
    this.totalPoints = 0,
  });

  bool isScanned(String stationId) => scannedStationIds.contains(stationId);

  StationsLoadedState copyWith({
    List<String>? scannedStationIds,
    ScanResult? scanResult,
    int? totalPoints,
  }) => StationsLoadedState(
    stations: stations,
    scannedStationIds: scannedStationIds ?? this.scannedStationIds,
    scanResult: scanResult ?? this.scanResult,
    totalPoints: totalPoints ?? this.totalPoints,
  );

  @override
  List<Object> get props => [stations, scannedStationIds, scanResult, totalPoints];
}
