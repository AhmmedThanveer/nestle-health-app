import '../entities/nsm_entity.dart';
import '../../core/utils/result.dart';

abstract class NsmRepository {
  Future<Result<List<NsmDayEntity>>> getNsmDays();
}
