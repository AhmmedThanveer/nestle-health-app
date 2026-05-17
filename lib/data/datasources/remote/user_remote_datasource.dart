import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/errors/exceptions.dart';
import '../../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<void> createUser(UserModel user);
  Future<UserModel> getUserById(String uid);
  Future<UserModel> updateUser(UserModel user);
  Future<void> updateFcmToken({required String uid, required String token});
  Future<void> deleteUser(String uid);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _db;
  const UserRemoteDataSourceImpl(this._db);

  CollectionReference get _users => _db.collection('users');

  @override
  Future<void> createUser(UserModel user) async {
    try {
      await _users.doc(user.uid).set(user.toFirestore());
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to create user profile');
    }
  }

  @override
  Future<UserModel> getUserById(String uid) async {
    try {
      final doc = await _users.doc(uid).get();
      if (!doc.exists) throw const ServerException('User profile not found');
      return UserModel.fromFirestore(doc);
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch user profile');
    }
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    try {
      // Only update profile fields — never touch points/scannedStations here.
      await _users.doc(user.uid).update({
        'firstName': user.firstName,
        'familyName': user.familyName,
        'mobile': user.mobile,
        'profession': user.profession,
        'city': user.city,
        'workplace': user.workplace,
        'saudiCouncilNumber': user.saudiCouncilNumber,
        'selectedTopic': user.selectedTopic,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return user;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to update user profile');
    }
  }

  @override
  Future<void> updateFcmToken({required String uid, required String token}) async {
    try {
      await _users.doc(uid).update({
        'fcmToken': token,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to update FCM token');
    }
  }

  @override
  Future<void> deleteUser(String uid) async {
    try {
      await _users.doc(uid).delete();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to delete user profile');
    }
  }
}
