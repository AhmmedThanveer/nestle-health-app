import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import '../../../domain/usecases/auth/change_password_usecase.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

export 'change_password_event.dart';
export 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordBloc()
      : _changePasswordUseCase = sl<ChangePasswordUseCase>(),
        super(const ChangePasswordState()) {
    on<ChangePasswordSubmitEvent>(_onSubmit);
    on<ChangePasswordResetEvent>(_onReset);
  }

  Future<void> _onSubmit(
    ChangePasswordSubmitEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(status: ChangePasswordStatus.loading));
    final result = await _changePasswordUseCase(
      currentPassword: event.currentPassword,
      newPassword: event.newPassword,
    );
    result.when(
      success: (_) => emit(state.copyWith(status: ChangePasswordStatus.success)),
      failure: (f) => emit(state.copyWith(
        status: ChangePasswordStatus.error,
        errorMessage: f.message,
      )),
    );
  }

  void _onReset(
    ChangePasswordResetEvent event,
    Emitter<ChangePasswordState> emit,
  ) =>
      emit(const ChangePasswordState());
}
