import 'package:daleeli/core/utils/failure/failure.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:daleeli/feature/saved_place/domain/repo/saved_places_repo.dart';
import 'package:dartz/dartz.dart';

class SavedPlaceUseCase {
  final SavedPlacesRepository repository;
  SavedPlaceUseCase(this.repository);

  Future<Either<Failure, void>> savePlace(PlacesEntity place) async {
    return await repository.savePlace(place);
  }

  
  Future<Either<Failure, void>> removePlace(String placeId) async {
    return await repository.removeSavedPlace(placeId);
  }

  Future<Either<Failure, List<PlacesEntity>>> getSavedPlaces() async {
    return await repository.getSavedPlaces();
  }
}
