import '../../../core/utils/result.dart';
import '../../repositories/station_repository.dart';

class AwardStationPointsUseCase {
  final StationRepository _repository;
  const AwardStationPointsUseCase(this._repository);

  Future<Result<void>> call({
    required String userId,
    required String stationId,
    required int points,
  }) =>
      _repository.awardPoints(
        userId: userId,
        stationId: stationId,
        points: points,
      );
}
