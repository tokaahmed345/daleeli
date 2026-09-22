import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AiSuggestionPlacesRepo {
  Future<Either<String, List<PlacesEntity>>> aiSuggestionsTrips();
}
