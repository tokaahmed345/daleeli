import 'package:daleeli/feature/ai_suggestions_places/domain/repo/ai_suggestion_trips_repo.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:dartz/dartz.dart';

class AiSuggestionPlacesUsecase {
  final AiSuggestionPlacesRepo trips;

  AiSuggestionPlacesUsecase({required this.trips});
  Future<Either<String, List<PlacesEntity>>> getSuggestionTrips() async {
    return await trips.aiSuggestionsTrips();
  }
}
