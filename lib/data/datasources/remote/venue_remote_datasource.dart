import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/models/venue_model.dart';

abstract class VenueRemoteDataSource {
  Future<VenueModel> getVenue();
}

class VenueRemoteDataSourceImpl implements VenueRemoteDataSource {
  final FirebaseFirestore _db;

  VenueRemoteDataSourceImpl(this._db);

  @override
  Future<VenueModel> getVenue() async {
    final doc = await _db.collection('venue').doc('config').get();
    return VenueModel.fromFirestore(doc);
  }
}
