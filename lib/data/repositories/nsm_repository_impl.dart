import '../../core/errors/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/nsm_entity.dart';
import '../../domain/repositories/nsm_repository.dart';
import '../datasources/remote/nsm_remote_datasource.dart';

class NsmRepositoryImpl implements NsmRepository {
  final NsmRemoteDataSource _dataSource;

  NsmRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<NsmDayEntity>>> getNsmDays() async {
    try {
      final days = await _dataSource.getNsmDays();
      return Success(days);
    } catch (e) {
      return Failure(ServerFailure(e.toString()));
    }
  }
}
