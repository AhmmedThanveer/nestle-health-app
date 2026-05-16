import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/result.dart';
import '../../data/datasources/remote/venue_remote_datasource.dart';
import '../../domain/entities/venue_entity.dart';
import '../../domain/repositories/venue_repository.dart';

class VenueRepositoryImpl implements VenueRepository {
  final VenueRemoteDataSource _dataSource;

  VenueRepositoryImpl(this._dataSource);

  @override
  Future<Result<VenueEntity>> getVenue() async {
    try {
      final venue = await _dataSource.getVenue();
      return Success(venue);
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(ServerFailure(e.toString()));
    }
  }
}
