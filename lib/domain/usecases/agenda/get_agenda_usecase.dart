import '../../../core/models/agenda_models.dart';
import '../../../core/utils/result.dart';
import '../../repositories/agenda_repository.dart';

class GetAgendaUseCase {
  final AgendaRepository _repository;
  const GetAgendaUseCase(this._repository);

  Future<Result<List<AgendaDay>>> call(String eventId) =>
      _repository.getAgenda(eventId);
}
