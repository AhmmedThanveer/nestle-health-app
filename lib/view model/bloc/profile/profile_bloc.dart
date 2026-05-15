import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import '../../../domain/usecases/auth/sign_out_usecase.dart';
import '../../../domain/usecases/user/get_current_user_usecase.dart';
import '../../../domain/usecases/user/update_profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

export 'profile_event.dart';
export 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetCurrentUserUseCase _getCurrentUser;
  final UpdateProfileUseCase _updateProfile;
  final SignOutUseCase _signOut;

  ProfileBloc()
      : _getCurrentUser = sl<GetCurrentUserUseCase>(),
        _updateProfile = sl<UpdateProfileUseCase>(),
        _signOut = sl<SignOutUseCase>(),
        super(const ProfileState()) {
    on<LoadProfileEvent>(_onLoad);
    on<UpdateProfileEvent>(_onUpdate);
    on<SignOutProfileEvent>(_onSignOut);
  }

  Future<void> _onLoad(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _getCurrentUser(event.uid);
    result.when(
      success: (user) =>
          emit(state.copyWith(status: ProfileStatus.loaded, user: user)),
      failure: (f) => emit(
          state.copyWith(status: ProfileStatus.error, errorMessage: f.message)),
    );
  }

  Future<void> _onUpdate(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.user == null) return;
    emit(state.copyWith(status: ProfileStatus.updating));

    final updated = state.user!.copyWith(
      firstName: event.firstName,
      familyName: event.familyName,
      mobile: event.mobile,
      profession: event.profession,
      city: event.city,
      workplace: event.workplace,
      saudiCouncilNumber: event.saudiCouncilNumber,
      selectedTopic: event.selectedTopic ?? state.user!.selectedTopic,
    );

    final result = await _updateProfile(updated);
    result.when(
      success: (user) =>
          emit(state.copyWith(status: ProfileStatus.updated, user: user)),
      failure: (f) => emit(
          state.copyWith(status: ProfileStatus.error, errorMessage: f.message)),
    );
  }

  Future<void> _onSignOut(
    SignOutProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    await _signOut();
    emit(state.copyWith(status: ProfileStatus.signedOut));
  }
}
