/// Lightweight in-memory store for cross-BLoC data that doesn't belong
/// in any single BLoC's state (e.g. the validated event id between the
/// EventCode screen and the Register screen).
class SessionStore {
  SessionStore._();
  static final SessionStore instance = SessionStore._();

  /// Populated by EventCodeBloc after a successful Firestore validation.
  /// Read by RegisterBloc when creating a user account.
  String? pendingEventId;

  /// UID of the currently signed-in user (set after login/register).
  String? currentUserId;

  void clear() {
    pendingEventId = null;
    currentUserId = null;
  }
}
