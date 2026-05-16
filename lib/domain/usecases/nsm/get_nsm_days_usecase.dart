import '../../entities/nsm_entity.dart';
import '../../repositories/nsm_repository.dart';
import '../../../core/utils/result.dart';

class GetNsmDaysUseCase {
  final NsmRepository _repository;

  GetNsmDaysUseCase(this._repository);

  Future<Result<List<NsmDayEntity>>> call() => _repository.getNsmDays();
}
