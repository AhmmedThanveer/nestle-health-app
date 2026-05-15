import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/station_entity.dart';
import '../../domain/repositories/station_repository.dart';
import '../datasources/remote/station_remote_datasource.dart';

class StationRepositoryImpl implements StationRepository {
  final StationRemoteDataSource _dataSource;
  const StationRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<StationEntity>>> getStations() async {
    try {
      final stations = await _dataSource.getStations();
      return Success(stations);
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> awardPoints({
    required String userId,
    required String stationId,
    required int points,
  }) async {
    try {
      await _dataSource.awardPoints(
        userId: userId,
        stationId: stationId,
        points: points,
      );
      return const Success(null);
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<String>>> getScannedStations(String userId) async {
    try {
      final ids = await _dataSource.getScannedStations(userId);
      return Success(ids);
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }
}
