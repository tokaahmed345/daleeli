import 'package:daleeli/feature/home/data/models/places_model.dart';

abstract class PlacesFirebaseRemoteDataSource {
  Future<List<PlacesModel>> getPlaces();
}


