import '../../core/models/speaker_models.dart';
import '../../core/utils/result.dart';

abstract class SpeakerRepository {
  Future<Result<List<Speaker>>> getSpeakers(String eventId);
}
