import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/errors/exceptions.dart';
import '../../models/nsm_model.dart';

abstract class NsmRemoteDataSource {
  Future<List<NsmDayModel>> getNsmDays();
}

class NsmRemoteDataSourceImpl implements NsmRemoteDataSource {
  final FirebaseFirestore _db;

  NsmRemoteDataSourceImpl(this._db);

  @override
  Future<List<NsmDayModel>> getNsmDays() async {
    try {
      final daysSnap = await _db
          .collection('nsm_days')
          .orderBy('sortOrder')
          .get();

      final List<NsmDayModel> result = [];

      for (final dayDoc in daysSnap.docs) {
        final wavesSnap = await dayDoc.reference
            .collection('waves')
            .orderBy('sortOrder')
            .get();

        final waves = wavesSnap.docs
            .map((d) => NsmWaveModel.fromFirestore(d))
            .toList();

        result.add(NsmDayModel.fromFirestore(dayDoc, waves));
      }

      return result;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
