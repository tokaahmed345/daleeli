import '../../../home/data/models/places_model.dart';
import '../../../home/domain/entity/places_entity.dart';

abstract class SavedPlacesFirebaseRemoteDataSource {
  Future<void> savePlace(PlacesEntity place);
  Future<void> removePlace(String placeId);
  Future<List<PlacesModel>> getSavedPlaces();
}
