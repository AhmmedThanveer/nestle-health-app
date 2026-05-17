import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/repositories/question_repository.dart';
import '../datasources/remote/question_remote_datasource.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionRemoteDataSource _remote;

  const QuestionRepositoryImpl(this._remote);

  @override
  Future<Result<void>> submitQuestion({
    required String name,
    required String speakerName,
    required String question,
  }) async {
    try {
      await _remote.submitQuestion(
        name: name,
        speakerName: speakerName,
        question: question,
      );
      return const Success(null);
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }
}
