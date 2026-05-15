abstract class EventCodeEvent {}

class ValidateEventCodeEvent extends EventCodeEvent {
  final String code;

  ValidateEventCodeEvent({required this.code});
}
