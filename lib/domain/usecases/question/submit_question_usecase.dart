import '../../../core/utils/result.dart';
import '../../repositories/question_repository.dart';

class SubmitQuestionUseCase {
  final QuestionRepository _repository;

  const SubmitQuestionUseCase(this._repository);

  Future<Result<void>> call({
    required String name,
    required String speakerName,
    required String question,
  }) =>
      _repository.submitQuestion(
        name: name,
        speakerName: speakerName,
        question: question,
      );
}
