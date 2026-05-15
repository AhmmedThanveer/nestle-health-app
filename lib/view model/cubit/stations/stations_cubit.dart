import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import '../../../domain/usecases/station/award_station_points_usecase.dart';
import '../../../domain/usecases/station/load_stations_usecase.dart';
import '../../../domain/repositories/station_repository.dart';
import 'stations_state.dart';

export 'stations_state.dart';

class StationsCubit extends Cubit<StationsState> {
  final LoadStationsUseCase _loadStations;
  final AwardStationPointsUseCase _awardPoints;
  final StationRepository _stationRepository;

  StationsCubit()
      : _loadStations = sl<LoadStationsUseCase>(),
        _awardPoints = sl<AwardStationPointsUseCase>(),
        _stationRepository = sl<StationRepository>(),
        super(const StationsState());

  /// Fetches station list + user's already-scanned IDs from Firestore.
  Future<void> loadStations(String userId) async {
    emit(state.copyWith(status: StationsStatus.loading));

    final stationsResult = await _loadStations();
    final scannedResult = await _stationRepository.getScannedStations(userId);

    stationsResult.when(
      success: (stations) {
        final scanned = scannedResult.when(
          success: (ids) => ids,
          failure: (_) => <String>[],
        );
        emit(state.copyWith(
          status: StationsStatus.loaded,
          stations: stations,
          scannedStationIds: scanned,
        ));
      },
      failure: (f) => emit(state.copyWith(
        status: StationsStatus.error,
        errorMessage: f.message,
      )),
    );
  }

  /// Called after QR scanner detects a code.
  /// [scannedCode] is the raw value from the camera.
  /// [stationId] is the station the user tapped "Scan" on.
  Future<void> processScan({
    required String userId,
    required String stationId,
    required String scannedCode,
  }) async {
    if (state.status != StationsStatus.loaded) return;

    // Find the station definition
    final station = state.stations.where((s) => s.id == stationId).firstOrNull;
    if (station == null) {
      emit(state.copyWith(scanResult: ScanResult.failure));
      return;
    }

    // Validate QR code matches this station's expected code
    if (scannedCode.trim() != station.qrCode.trim()) {
      emit(state.copyWith(scanResult: ScanResult.failure));
      return;
    }

    // Already scanned in this session
    if (state.isScanned(stationId)) {
      emit(state.copyWith(
        scanResult: ScanResult.alreadyScanned,
        lastScannedStation: station,
      ));
      return;
    }

    emit(state.copyWith(status: StationsStatus.scanning));

    final result = await _awardPoints(
      userId: userId,
      stationId: stationId,
      points: station.points,
    );

    result.when(
      success: (_) => emit(state.copyWith(
        status: StationsStatus.loaded,
        scannedStationIds: [...state.scannedStationIds, stationId],
        scanResult: ScanResult.success,
        lastScannedStation: station,
        sessionPoints: state.sessionPoints + station.points,
      )),
      failure: (f) {
        // ignore: avoid_print
        print('AWARD DEBUG → Firestore error: ${f.message}');
        emit(state.copyWith(
          status: StationsStatus.loaded,
          scanResult: ScanResult.failure,
          errorMessage: f.message,
        ));
      },
    );
  }

  void dismissScanResult() {
    emit(state.copyWith(
      scanResult: ScanResult.none,
      clearLastStation: true,
    ));
  }
}
