import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/station_models.dart';
import 'stations_event.dart';
import 'stations_state.dart';

class StationsBloc extends Bloc<StationsEvent, StationsState> {
  StationsBloc() : super(const StationsLoadingState()) {
    on<LoadStationsEvent>(_onLoad);
    on<ScanStationEvent>(_onScan);
    on<DismissScanResultEvent>(_onDismiss);
  }

  void _onLoad(LoadStationsEvent event, Emitter<StationsState> emit) {
    emit(const StationsLoadedState(stations: StationsData.stations));
  }

  void _onScan(ScanStationEvent event, Emitter<StationsState> emit) {
    if (state is! StationsLoadedState) return;
    final current = state as StationsLoadedState;

    // Locate the target station definition (contains its expected QR value).
    final station = StationsData.stations.firstWhere(
      (s) => s.id == event.stationId,
    );

    if (event.scannedCode == station.qrCode) {
      final alreadyScanned = current.isScanned(event.stationId);
      emit(current.copyWith(
        scannedStationIds: alreadyScanned
            ? current.scannedStationIds
            : [...current.scannedStationIds, event.stationId],
        scanResult: ScanResult.success,
        totalPoints: alreadyScanned
            ? current.totalPoints
            : current.totalPoints + station.points,
      ));
    } else {
      emit(current.copyWith(scanResult: ScanResult.failure));
    }
  }

  void _onDismiss(DismissScanResultEvent event, Emitter<StationsState> emit) {
    if (state is StationsLoadedState) {
      emit((state as StationsLoadedState).copyWith(scanResult: ScanResult.none));
    }
  }
}
