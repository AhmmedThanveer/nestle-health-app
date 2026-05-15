import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/models/speaker_models.dart';
import '../../models/speaker_model.dart';

abstract class SpeakerRemoteDataSource {
  Future<List<Speaker>> getSpeakers(String eventId);
}

class SpeakerRemoteDataSourceImpl implements SpeakerRemoteDataSource {
  final FirebaseFirestore _db;
  const SpeakerRemoteDataSourceImpl(this._db);

  @override
  Future<List<Speaker>> getSpeakers(String eventId) async {
    try {
      final snap = await _db
          .collection('speakers')
          .where('eventId', isEqualTo: eventId.trim())
          .get();
      final docs = snap.docs
        ..sort((a, b) {
          final aOrder = (a.data()['order'] as num? ?? 0).toInt();
          final bOrder = (b.data()['order'] as num? ?? 0).toInt();
          return aOrder.compareTo(bOrder);
        });
      return docs.map(SpeakerModel.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to load speakers');
    }
  }
}
