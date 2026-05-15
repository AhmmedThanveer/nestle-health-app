import 'package:equatable/equatable.dart';

class EventCodeState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? validatedEventId;

  const EventCodeState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.validatedEventId,
  });

  EventCodeState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? validatedEventId,
    bool clearError = false,
  }) =>
      EventCodeState(
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
        validatedEventId: validatedEventId ?? this.validatedEventId,
      );

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        errorMessage,
        validatedEventId,
      ];
}
