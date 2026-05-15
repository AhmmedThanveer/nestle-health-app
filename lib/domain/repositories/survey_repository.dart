import '../../core/utils/result.dart';

abstract class SurveyRepository {
  Future<Result<bool>> submitSurvey({
    required String userId,
    required String eventId,
    required Map<String, String> answers,
  });
}
