abstract class AppFailure {
  final String message;
  const AppFailure(this.message);
}

class AuthFailure extends AppFailure {
  const AuthFailure(super.message);
}

class ServerFailure extends AppFailure {
  const ServerFailure(super.message);
}

class NetworkFailure extends AppFailure {
  const NetworkFailure(super.message);
}

class EventNotFoundFailure extends AppFailure {
  const EventNotFoundFailure(super.message);
}

class EventInactiveFailure extends AppFailure {
  const EventInactiveFailure(super.message);
}

class DuplicateRegistrationFailure extends AppFailure {
  const DuplicateRegistrationFailure(super.message);
}

class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure(super.message);
}
