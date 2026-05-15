import '../../entities/event_entity.dart';
import '../../repositories/event_repository.dart';
import '../../../core/utils/result.dart';

class ValidateEventCodeUseCase {
  final EventRepository _repository;
  const ValidateEventCodeUseCase(this._repository);

  Future<Result<EventEntity>> call(String code) =>
      _repository.validateEventCode(code);
}
