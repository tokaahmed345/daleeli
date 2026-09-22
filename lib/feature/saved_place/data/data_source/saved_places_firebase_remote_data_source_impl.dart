// import 'package:daleeli/core/utils/networking/firebase/firestore/firebase_firestore_service.dart';
// import 'package:daleeli/core/utils/networking/firebase/firestore/firestore_fields.dart';
// import 'package:daleeli/feature/home/data/models/places_model.dart';
// import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
// import 'package:daleeli/feature/saved_place/data/data_source/saved_places_firebase_remote_data_source.dart';

// class SavedPlacesFirebaseRemoteDataSourceImpl
//     implements SavedPlacesFirebaseRemoteDataSource {
//   final FirebaseFirestoreService firestore;
//   SavedPlacesFirebaseRemoteDataSourceImpl({required this.firestore});

//   @override
//   Future<void> savePlace(PlacesEntity place) async {
//     final placeModel = PlacesModel.fromEntity(place, isSaved: true);

//     await firestore.postData(
//       collectionPath: FirestoreFields.savedPlaces,
//       data: placeModel.toJson(),
//       documentId: place.id,
//     );
//   }

//   @override
//   Future<void> removePlace(String placeId) async {
//     await firestore.deleteData(
//       collectionPath: FirestoreFields.savedPlaces,
//       documentId: placeId,
//     );
//   }

//   @override
//   Future<List<PlacesModel>> getSavedPlaces() async {
//     final querySnapshot = await firestore.getCollection(
//       collectionPath: FirestoreFields.savedPlaces,
//     );

//     return querySnapshot.docs
//         .map((doc) => PlacesModel.fromJson(doc.data(), doc.id, isSaved: true))
//         .toList();
//   }
// }

import 'package:daleeli/core/utils/networking/firebase/firestore/firebase_firestore_service.dart';
import 'package:daleeli/core/utils/networking/firebase/firestore/firestore_fields.dart';
import 'package:daleeli/feature/home/data/models/places_model.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:daleeli/feature/saved_place/data/data_source/saved_places_firebase_remote_data_source.dart';

class SavedPlacesFirebaseRemoteDataSourceImpl
    implements SavedPlacesFirebaseRemoteDataSource {
  final FirebaseFirestoreService firestore;
  SavedPlacesFirebaseRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> savePlace(PlacesEntity place) async {
    await firestore.patchData(
      collectionPath: FirestoreFields.plaaces,
      documentId: place.id,
      data: {'isSaved': true},
    );
  }

  @override
  Future<void> removePlace(String placeId) async {
    await firestore.patchData(
      collectionPath: FirestoreFields.plaaces,
      documentId: placeId,
      data: {'isSaved': false},
    );
  }

  @override
  Future<List<PlacesModel>> getSavedPlaces() async {
    final querySnapshot = await firestore.getCollection(
      collectionPath: FirestoreFields.plaaces,
         queryBuilder: (collection) =>
          collection.where('isSaved', isEqualTo: true),
    );

    return querySnapshot.docs
        .map((doc) => PlacesModel.fromJson(doc.data(), doc.id))
        .where((place) => place.isSaved)
        .toList();
  }
}
