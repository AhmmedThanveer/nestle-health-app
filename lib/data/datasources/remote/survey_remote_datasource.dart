import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/errors/exceptions.dart';

abstract class SurveyRemoteDataSource {
  Future<void> submitSurvey({
    required String userId,
    required String eventId,
    required Map<String, String> answers,
  });
}

class SurveyRemoteDataSourceImpl implements SurveyRemoteDataSource {
  final FirebaseFirestore _db;
  const SurveyRemoteDataSourceImpl(this._db);

  @override
  Future<void> submitSurvey({
    required String userId,
    required String eventId,
    required Map<String, String> answers,
  }) async {
    try {
      await _db.collection('surveys').add({
        'userId': userId,
        'eventId': eventId.trim(),
        'answers': answers,
        'submittedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to submit survey');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
