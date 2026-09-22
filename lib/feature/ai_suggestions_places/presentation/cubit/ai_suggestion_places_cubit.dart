import 'package:bloc/bloc.dart';
import 'package:daleeli/feature/ai_suggestions_places/domain/usecase/ai_suggestion_trips_usecase.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:equatable/equatable.dart';

part 'ai_suggestion_places_state.dart';

class AiSuggestionPlacesCubit extends Cubit<AiSuggestionPlacesState> {
  AiSuggestionPlacesCubit(this.trips) : super(AiSuggestionPlacesInitial());

  final AiSuggestionPlacesUsecase trips;
  Future<void> getSuggestionsTrips() async {
    emit(AiSuggestionPlacesLoading());
    final result = await trips.getSuggestionTrips();
    result.fold(
      (errorMsg) => emit(AiSuggestionPlacesFailure(meessage: errorMsg)),

      (placesList) => emit(AiSuggestionPlacesSuccess(trips: placesList)),
    );
  }
}
