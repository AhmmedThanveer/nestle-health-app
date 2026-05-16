import 'package:equatable/equatable.dart';

import '../../../domain/entities/venue_entity.dart';

enum VenueStatus { initial, loading, loaded, error }

class VenueState extends Equatable {
  final VenueStatus status;
  final VenueEntity? venue;
  final String? errorMessage;

  const VenueState({
    this.status = VenueStatus.initial,
    this.venue,
    this.errorMessage,
  });

  VenueState copyWith({
    VenueStatus? status,
    VenueEntity? venue,
    String? errorMessage,
  }) =>
      VenueState(
        status: status ?? this.status,
        venue: venue ?? this.venue,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [status, venue, errorMessage];
}
