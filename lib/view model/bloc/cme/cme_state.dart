import 'package:equatable/equatable.dart';

enum CmeStatus { initial, loading, eligible, notEligible, error }

class CmeState extends Equatable {
  final CmeStatus status;
  final String? certificateUrl;
  final String? errorMessage;

  const CmeState({
    this.status = CmeStatus.initial,
    this.certificateUrl,
    this.errorMessage,
  });

  CmeState copyWith({
    CmeStatus? status,
    String? certificateUrl,
    String? errorMessage,
  }) =>
      CmeState(
        status: status ?? this.status,
        certificateUrl: certificateUrl ?? this.certificateUrl,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [status, certificateUrl, errorMessage];
}
