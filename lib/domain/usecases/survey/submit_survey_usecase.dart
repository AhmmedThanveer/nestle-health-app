import '../../../core/utils/result.dart';
import '../../repositories/survey_repository.dart';

class SubmitSurveyUseCase {
  final SurveyRepository _repo;
  const SubmitSurveyUseCase(this._repo);

  Future<Result<bool>> call({
    required String userId,
    required String eventId,
    required Map<String, String> answers,
  }) =>
      _repo.submitSurvey(
        userId: userId,
        eventId: eventId,
        answers: answers,
      );
}
