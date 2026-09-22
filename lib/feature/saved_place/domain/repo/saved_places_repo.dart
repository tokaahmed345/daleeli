import 'package:daleeli/core/utils/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../home/domain/entity/places_entity.dart';

abstract class SavedPlacesRepository {
  Future<Either<Failure, void>> savePlace(PlacesEntity place);
  Future<Either<Failure, void>> removeSavedPlace(String placeId);
  Future<Either<Failure, List<PlacesEntity>>> getSavedPlaces();
}
