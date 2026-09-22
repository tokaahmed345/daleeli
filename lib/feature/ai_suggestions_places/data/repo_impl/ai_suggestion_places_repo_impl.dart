import 'package:daleeli/feature/ai_suggestions_places/data/data_source/ai_suggestion_trips_remote_data_source.dart';
import 'package:daleeli/feature/ai_suggestions_places/domain/repo/ai_suggestion_trips_repo.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AiSuggestionPlacesRepoImpl implements AiSuggestionPlacesRepo {
  final AiSuggestionTripsRemoteDataSource tripsRemoteDataSource;

  AiSuggestionPlacesRepoImpl({required this.tripsRemoteDataSource});
  @override
  Future<Either<String, List<PlacesEntity>>> aiSuggestionsTrips() async {
    try {
      final trips = await tripsRemoteDataSource.suggestPlaces();
      return right(trips);
    } on FirebaseException catch (e) {
      return left(e.message.toString());
    } catch (e) {
      return left(e.toString());
    }
  }
}
