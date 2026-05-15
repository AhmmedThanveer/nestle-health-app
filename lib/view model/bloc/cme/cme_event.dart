import 'package:equatable/equatable.dart';

abstract class CmeEvent extends Equatable {
  const CmeEvent();
  @override
  List<Object?> get props => [];
}

class CheckCmeEligibilityEvent extends CmeEvent {
  final String uid;
  const CheckCmeEligibilityEvent(this.uid);
  @override
  List<Object?> get props => [uid];
}
