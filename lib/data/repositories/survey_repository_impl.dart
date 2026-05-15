import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/repositories/survey_repository.dart';
import '../datasources/remote/survey_remote_datasource.dart';

class SurveyRepositoryImpl implements SurveyRepository {
  final SurveyRemoteDataSource _dataSource;
  const SurveyRepositoryImpl(this._dataSource);

  @override
  Future<Result<bool>> submitSurvey({
    required String userId,
    required String eventId,
    required Map<String, String> answers,
  }) async {
    try {
      await _dataSource.submitSurvey(
        userId: userId,
        eventId: eventId,
        answers: answers,
      );
      return const Success(true);
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }
}
