import 'package:daleeli/core/utils/networking/firebase/firestore/firebase_firestore_service.dart';
import 'package:daleeli/core/utils/networking/firebase/firestore/firestore_fields.dart';
import 'package:daleeli/feature/home/data/data_source/places_firebase_remote_data_source.dart';
import 'package:daleeli/feature/home/data/models/places_model.dart';

class PlacesRemoteDataSourceImpl implements PlacesFirebaseRemoteDataSource {
  final FirebaseFirestoreService firestore;

  PlacesRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<PlacesModel>> getPlaces() async {
    final querySnapshot = await firestore.getCollection(
      collectionPath: FirestoreFields.plaaces,
    );

    List<PlacesModel> places = querySnapshot.docs
        .map((doc) => PlacesModel.fromJson(doc.data(), doc.id))
        .toList();

    return places;
  }
}
