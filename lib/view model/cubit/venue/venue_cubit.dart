import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import '../../../domain/usecases/venue/get_venue_usecase.dart';
import 'venue_state.dart';

export 'venue_state.dart';

class VenueCubit extends Cubit<VenueState> {
  final GetVenueUseCase _getVenue;

  VenueCubit()
      : _getVenue = sl<GetVenueUseCase>(),
        super(const VenueState());

  Future<void> load() async {
    emit(state.copyWith(status: VenueStatus.loading));
    final result = await _getVenue();
    result.when(
      success: (venue) => emit(state.copyWith(
        status: VenueStatus.loaded,
        venue: venue,
      )),
      failure: (f) => emit(state.copyWith(
        status: VenueStatus.error,
        errorMessage: f.message,
      )),
    );
  }
}
