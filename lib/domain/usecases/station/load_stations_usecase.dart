import '../../../core/utils/result.dart';
import '../../entities/station_entity.dart';
import '../../repositories/station_repository.dart';

class LoadStationsUseCase {
  final StationRepository _repository;
  const LoadStationsUseCase(this._repository);

  Future<Result<List<StationEntity>>> call() => _repository.getStations();
}
