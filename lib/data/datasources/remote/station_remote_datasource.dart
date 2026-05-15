import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/errors/exceptions.dart';
import '../../models/station_model.dart';

abstract class StationRemoteDataSource {
  Future<List<StationModel>> getStations();
  Future<void> awardPoints({
    required String userId,
    required String stationId,
    required int points,
  });
  Future<List<String>> getScannedStations(String userId);
}

class StationRemoteDataSourceImpl implements StationRemoteDataSource {
  final FirebaseFirestore _db;
  const StationRemoteDataSourceImpl(this._db);

  CollectionReference get _stations => _db.collection('stations');
  CollectionReference get _users => _db.collection('users');

  @override
  Future<List<StationModel>> getStations() async {
    try {
      final snap = await _stations.get();
      return snap.docs.map(StationModel.fromFirestore).toList()
        ..sort((a, b) => a.name.compareTo(b.name));
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to load stations');
    }
  }

  /// Atomically awards points. Uses a transaction to prevent double-earning.
  @override
  Future<void> awardPoints({
    required String userId,
    required String stationId,
    required int points,
  }) async {
    try {
      final userRef = _users.doc(userId);
      await _db.runTransaction((tx) async {
        final snap = await tx.get(userRef);
        if (!snap.exists) throw const ServerException('User not found');
        final data = snap.data() as Map<String, dynamic>? ?? {};
        final scanned = List<String>.from(data['scannedStations'] ?? []);
        if (scanned.contains(stationId)) return; // idempotent — already earned
        tx.update(userRef, {
          'points': FieldValue.increment(points),
          'scannedStations': FieldValue.arrayUnion([stationId]),
        });
      });
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to award points');
    }
  }

  @override
  Future<List<String>> getScannedStations(String userId) async {
    try {
      final doc = await _users.doc(userId).get();
      if (!doc.exists) return [];
      final data = doc.data() as Map<String, dynamic>?;
      return List<String>.from(data?['scannedStations'] ?? []);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch scanned stations');
    }
  }
}
