import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/models/speaker_models.dart';
import '../../core/utils/result.dart';
import '../../domain/repositories/speaker_repository.dart';
import '../datasources/remote/speaker_remote_datasource.dart';

class SpeakerRepositoryImpl implements SpeakerRepository {
  final SpeakerRemoteDataSource _dataSource;
  const SpeakerRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<Speaker>>> getSpeakers(String eventId) async {
    try {
      final speakers = await _dataSource.getSpeakers(eventId);
      return Success(speakers);
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }
}
