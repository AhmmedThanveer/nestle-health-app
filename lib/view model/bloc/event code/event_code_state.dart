import 'package:equatable/equatable.dart';

class EventCodeState extends Equatable {
  final bool isLoading;

  final bool isSuccess;

  final String? errorMessage;

  const EventCodeState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  EventCodeState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return EventCodeState(
      isLoading: isLoading ?? this.isLoading,

      isSuccess: isSuccess ?? this.isSuccess,

      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}
