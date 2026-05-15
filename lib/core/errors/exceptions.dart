class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
  @override
  String toString() => message;
}

class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
  @override
  String toString() => message;
}

class EventNotFoundException implements Exception {
  const EventNotFoundException();
  @override
  String toString() => 'Event not found';
}

class EventInactiveException implements Exception {
  const EventInactiveException();
  @override
  String toString() => 'Event is not currently active';
}

class DuplicateRegistrationException implements Exception {
  const DuplicateRegistrationException();
  @override
  String toString() => 'Already registered for this event';
}
