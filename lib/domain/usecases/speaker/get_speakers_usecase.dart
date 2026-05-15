import '../../../core/models/speaker_models.dart';
import '../../../core/utils/result.dart';
import '../../repositories/speaker_repository.dart';

class GetSpeakersUseCase {
  final SpeakerRepository _repository;
  const GetSpeakersUseCase(this._repository);

  Future<Result<List<Speaker>>> call(String eventId) =>
      _repository.getSpeakers(eventId);
}
