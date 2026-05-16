import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import '../../../core/models/asset_models.dart';
import 'assets_event.dart';
import 'assets_state.dart';

export 'assets_event.dart';
export 'assets_state.dart';

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {
  final FirebaseFirestore _db;

  AssetsBloc()
      : _db = sl<FirebaseFirestore>(),
        super(const AssetsState()) {
    on<LoadAssetsEvent>(_onLoad);
  }

  Future<void> _onLoad(LoadAssetsEvent event, Emitter<AssetsState> emit) async {
    emit(state.copyWith(status: AssetsStatus.loading, clearError: true));
    try {
      final snap = await _db.collection('asset_folders').get();

      if (snap.docs.isEmpty) {
        emit(state.copyWith(status: AssetsStatus.empty, folders: []));
        return;
      }

      final folders = snap.docs.map((doc) {
        final data = doc.data();
        final rawFiles = (data['files'] as List? ?? [])
            .whereType<Map>()
            .map((f) => Map<String, dynamic>.from(f))
            .toList();

        final files = rawFiles.map((f) => AssetFile(
              name: (f['name'] as String?) ?? '',
              pdfUrl: (f['url'] as String?) ?? '',
              fileSize: (f['fileSize'] as String?) ?? '',
              fileType: (f['fileType'] as String?) ?? 'PDF',
              localFileName: (f['localFileName'] as String?) ?? '',
            )).toList();

        return AssetFolder(
          name: (data['name'] as String?) ?? '',
          files: files,
        );
      }).toList();

      emit(state.copyWith(status: AssetsStatus.loaded, folders: folders.toList()));
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-request-failed') {
        emit(state.copyWith(status: AssetsStatus.noInternet));
      } else {
        emit(state.copyWith(
          status: AssetsStatus.serverError,
          errorMessage: e.message,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: AssetsStatus.noInternet));
    }
  }
}
