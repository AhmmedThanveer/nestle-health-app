import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/entities/registration_entity.dart';
import '../../domain/repositories/event_repository.dart';
import '../datasources/remote/event_remote_datasource.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource _ds;
  const EventRepositoryImpl(this._ds);

  @override
  Future<Result<EventEntity>> validateEventCode(String code) async {
    try {
      return Success(await _ds.validateEventCode(code));
    } on EventNotFoundException {
      return const Failure(
        EventNotFoundFailure('Invalid event code. Please check and try again.'),
      );
    } on EventInactiveException {
      return const Failure(
        EventInactiveFailure('This event is no longer active.'),
      );
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Result<RegistrationEntity>> registerForEvent({
    required String userId,
    required String eventId,
  }) async {
    try {
      return Success(
        await _ds.registerForEvent(userId: userId, eventId: eventId),
      );
    } on DuplicateRegistrationException {
      return const Failure(
        DuplicateRegistrationFailure(
          'You are already registered for this event.',
        ),
      );
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Result<bool>> checkExistingRegistration({
    required String userId,
    required String eventId,
  }) async {
    try {
      return Success(
        await _ds.checkExistingRegistration(
          userId: userId,
          eventId: eventId,
        ),
      );
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }
}
