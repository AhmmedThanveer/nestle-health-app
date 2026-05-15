import '../../core/models/agenda_models.dart';
import '../../core/utils/result.dart';

abstract class AgendaRepository {
  Future<Result<List<AgendaDay>>> getAgenda(String eventId);
}
