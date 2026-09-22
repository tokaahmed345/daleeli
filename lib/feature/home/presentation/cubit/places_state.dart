import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:equatable/equatable.dart';

sealed class PlacesState extends Equatable {
  const PlacesState();
  
  @override
  List<Object?> get props => [];
}

class PlacesInitial extends PlacesState {}

class PlacesLoading extends PlacesState {}

class PlacesLoaded extends PlacesState {
  final List<PlacesEntity> allPlaces;
  final List<PlacesEntity> filteredPlaces;
  final String selectedGovernorate;
  final String selectedCategory;

  const PlacesLoaded({
    required this.allPlaces,
    required this.filteredPlaces,
    required this.selectedGovernorate,
    required this.selectedCategory,
  });

  @override
  List<Object?> get props => [
        allPlaces,
        filteredPlaces,
        selectedGovernorate,
        selectedCategory,
      ];
}

class PlacesError extends PlacesState {
  final String message;

  const PlacesError(this.message);

  @override
  List<Object?> get props => [message];
}