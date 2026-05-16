import '../entities/venue_entity.dart';
import '../../core/utils/result.dart';

abstract class VenueRepository {
  Future<Result<VenueEntity>> getVenue();
}
