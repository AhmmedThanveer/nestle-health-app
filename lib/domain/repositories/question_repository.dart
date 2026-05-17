import '../../core/utils/result.dart';

abstract class QuestionRepository {
  Future<Result<void>> submitQuestion({
    required String name,
    required String speakerName,
    required String question,
  });
}
