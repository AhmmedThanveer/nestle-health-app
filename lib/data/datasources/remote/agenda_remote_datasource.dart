import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/models/agenda_models.dart';
import '../../models/agenda_model.dart';

abstract class AgendaRemoteDataSource {
  Future<List<AgendaDay>> getAgenda(String eventId);
}

class AgendaRemoteDataSourceImpl implements AgendaRemoteDataSource {
  final FirebaseFirestore _db;
  const AgendaRemoteDataSourceImpl(this._db);

  @override
  Future<List<AgendaDay>> getAgenda(String eventId) async {
    try {
      final snap = await _db
          .collection('agenda')
          .where('eventId', isEqualTo: eventId.trim())
          .get();
      final docs = snap.docs
        ..sort((a, b) {
          final aOrder = (a.data()['order'] as num? ?? 0).toInt();
          final bOrder = (b.data()['order'] as num? ?? 0).toInt();
          return aOrder.compareTo(bOrder);
        });
      return docs.map(AgendaDayModel.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to load agenda');
    }
  }
}
