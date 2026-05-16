import '../../entities/venue_entity.dart';
import '../../repositories/venue_repository.dart';
import '../../../core/utils/result.dart';

class GetVenueUseCase {
  final VenueRepository _repository;
  const GetVenueUseCase(this._repository);

  Future<Result<VenueEntity>> call() => _repository.getVenue();
}
