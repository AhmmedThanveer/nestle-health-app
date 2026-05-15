import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/errors/exceptions.dart';
import '../../models/event_model.dart';
import '../../models/registration_model.dart';

abstract class EventRemoteDataSource {
  Future<EventModel> validateEventCode(String code);
  Future<RegistrationModel> registerForEvent({
    required String userId,
    required String eventId,
  });
  Future<bool> checkExistingRegistration({
    required String userId,
    required String eventId,
  });
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final FirebaseFirestore _db;
  const EventRemoteDataSourceImpl(this._db);

  CollectionReference get _events => _db.collection('events');
  CollectionReference get _registrations => _db.collection('registrations');

  @override
  Future<EventModel> validateEventCode(String code) async {
    try {
      final query = await _events
          .where('code', isEqualTo: code.toUpperCase().trim())
          .limit(1)
          .get();

      if (query.docs.isEmpty) throw const EventNotFoundException();

      final event = EventModel.fromFirestore(query.docs.first);
      if (!event.isActive) throw const EventInactiveException();

      return event;
    } on EventNotFoundException {
      rethrow;
    } on EventInactiveException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to validate event code');
    }
  }

  @override
  Future<RegistrationModel> registerForEvent({
    required String userId,
    required String eventId,
  }) async {
    try {
      final exists = await checkExistingRegistration(
        userId: userId,
        eventId: eventId,
      );
      if (exists) throw const DuplicateRegistrationException();

      final ref = _registrations.doc();
      final model = RegistrationModel(
        id: ref.id,
        userId: userId,
        eventId: eventId,
        status: 'active',
        registeredAt: DateTime.now(),
      );
      await ref.set(model.toFirestore());
      return model;
    } on DuplicateRegistrationException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to register for event');
    }
  }

  @override
  Future<bool> checkExistingRegistration({
    required String userId,
    required String eventId,
  }) async {
    try {
      final query = await _registrations
          .where('userId', isEqualTo: userId)
          .where('eventId', isEqualTo: eventId)
          .limit(1)
          .get();
      return query.docs.isNotEmpty;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to check registration');
    }
  }
}
