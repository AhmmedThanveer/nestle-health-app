import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/models/agenda_models.dart';
import '../../core/utils/result.dart';
import '../../domain/repositories/agenda_repository.dart';
import '../datasources/remote/agenda_remote_datasource.dart';

class AgendaRepositoryImpl implements AgendaRepository {
  final AgendaRemoteDataSource _dataSource;
  const AgendaRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<AgendaDay>>> getAgenda(String eventId) async {
    try {
      final days = await _dataSource.getAgenda(eventId);
      return Success(days);
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }
}
