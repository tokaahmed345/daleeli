part of 'saved_places_cubit.dart';

sealed class SavedPlacesState extends Equatable {
  const SavedPlacesState();

  @override
  List<Object> get props => [];
}

final class SavedPlacesInitial extends SavedPlacesState {}



class SavedLoading extends SavedPlacesState {}

class SavedItemSuccess extends SavedPlacesState {}

class SavedPlacesLoaded extends SavedPlacesState {
  final List<PlacesEntity> savedPlaces;
  const SavedPlacesLoaded(this.savedPlaces);
  @override
  List<Object> get props => [savedPlaces];
}

class SavedError extends SavedPlacesState {
  final String message;
  const SavedError(this.message);
  @override
  List<Object> get props => [message];
}