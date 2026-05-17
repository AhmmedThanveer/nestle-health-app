import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/errors/exceptions.dart';
import '../../../data/models/venue_model.dart';

abstract class VenueRemoteDataSource {
  Future<VenueModel> getVenue();
}

class VenueRemoteDataSourceImpl implements VenueRemoteDataSource {
  final FirebaseFirestore _db;

  VenueRemoteDataSourceImpl(this._db);

  @override
  Future<VenueModel> getVenue() async {
    final snap = await _db.collection('venue').limit(1).get();
    if (snap.docs.isEmpty) throw const ServerException('Venue not configured');
    return VenueModel.fromFirestore(snap.docs.first);
  }
}
