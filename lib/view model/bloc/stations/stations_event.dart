import 'package:equatable/equatable.dart';

abstract class StationsEvent extends Equatable {
  const StationsEvent();
}

class LoadStationsEvent extends StationsEvent {
  const LoadStationsEvent();

  @override
  List<Object> get props => [];
}

/// Fired when the user's camera detects a QR code on a specific station.
class ScanStationEvent extends StationsEvent {
  final String stationId;
  final String scannedCode;

  const ScanStationEvent({required this.stationId, required this.scannedCode});

  @override
  List<Object> get props => [stationId, scannedCode];
}

/// Resets [ScanResult] to [ScanResult.none] after the UI has handled the result.
class DismissScanResultEvent extends StationsEvent {
  const DismissScanResultEvent();

  @override
  List<Object> get props => [];
}
