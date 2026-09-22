part of 'ai_suggestion_places_cubit.dart';

sealed class AiSuggestionPlacesState extends Equatable {
  const AiSuggestionPlacesState();

  @override
  List<Object> get props => [];
}

final class AiSuggestionPlacesInitial extends AiSuggestionPlacesState {}

final class AiSuggestionPlacesLoading extends AiSuggestionPlacesState {}

final class AiSuggestionPlacesSuccess extends AiSuggestionPlacesState {
  final List<PlacesEntity> trips;

  const AiSuggestionPlacesSuccess({required this.trips});

  @override
  List<Object> get props => [trips];
}

final class AiSuggestionPlacesFailure extends AiSuggestionPlacesState {
  final String meessage;

  const AiSuggestionPlacesFailure({required this.meessage});
  @override
  List<Object> get props => [meessage];
}
