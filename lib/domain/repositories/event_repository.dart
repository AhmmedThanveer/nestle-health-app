import '../entities/event_entity.dart';
import '../entities/registration_entity.dart';
import '../../core/utils/result.dart';

abstract class EventRepository {
  Future<Result<EventEntity>> validateEventCode(String code);
  Future<Result<RegistrationEntity>> registerForEvent({
    required String userId,
    required String eventId,
  });
  Future<Result<bool>> checkExistingRegistration({
    required String userId,
    required String eventId,
  });
}
