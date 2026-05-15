import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/asset_models.dart';
import 'assets_event.dart';
import 'assets_state.dart';

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {
  AssetsBloc() : super(const AssetsInitialState()) {
    on<LoadAssetsEvent>(_onLoad);
  }

  void _onLoad(LoadAssetsEvent event, Emitter<AssetsState> emit) {
    emit(const AssetsLoadedState(AssetsData.folders));
  }
}
