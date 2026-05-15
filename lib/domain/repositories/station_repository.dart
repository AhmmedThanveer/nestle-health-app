import '../entities/station_entity.dart';
import '../../core/utils/result.dart';

abstract class StationRepository {
  Future<Result<List<StationEntity>>> getStations();

  /// Awards [points] to [userId] for scanning [stationId].
  /// Idempotent — second scan of same station returns success but earns 0 pts.
  Future<Result<void>> awardPoints({
    required String userId,
    required String stationId,
    required int points,
  });

  /// Returns the list of station IDs already scanned by [userId].
  Future<Result<List<String>>> getScannedStations(String userId);
}
