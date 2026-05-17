import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class QuestionRemoteDataSource {
  Future<void> submitQuestion({
    required String name,
    required String speakerName,
    required String question,
  });
}

class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSource {
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;

  QuestionRemoteDataSourceImpl(this._db, this._auth);

  @override
  Future<void> submitQuestion({
    required String name,
    required String speakerName,
    required String question,
  }) async {
    await _db.collection('questions').add({
      'name': name,
      'speakerName': speakerName,
      'question': question,
      'userId': _auth.currentUser?.uid ?? '',
      'submittedAt': FieldValue.serverTimestamp(),
    });
  }
}
