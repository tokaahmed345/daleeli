import 'package:bloc/bloc.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:daleeli/feature/home/domain/usecase/places_usecase.dart';
import 'package:daleeli/feature/home/presentation/cubit/places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  final GetPlacesUseCase getPlacesUseCase;

  PlacesCubit(this.getPlacesUseCase) : super(PlacesInitial());

  String _currentGovernorate = "All";
  String _currentCategory = "All";
  List<PlacesEntity> _cachedPlaces = [];

  void fetchPlaces() async {
    if (isClosed) return;
    emit(PlacesLoading());

    final placesResult = await getPlacesUseCase.fetchPlaces();

    if (isClosed) return;

    placesResult.fold((failure) => emit(PlacesError(failure.message)), (
      places,
    ) {
      _cachedPlaces = places;
      _applyFilters();
    });
  }

  void filterByGovernorate(String governorate) {
    _currentGovernorate = governorate;
    _applyFilters();
  }

  void filterByCategory(String category) {
    _currentCategory = category;
    _applyFilters();
  }

  void _applyFilters() {
    var filtered = _cachedPlaces.where((place) {
      bool matchesGov =
          _currentGovernorate == "All" || place.location == _currentGovernorate;
      bool matchesCat =
          _currentCategory == "All" || place.category == _currentCategory;
      return matchesGov && matchesCat;
    }).toList();

    emit(
      PlacesLoaded(
        allPlaces: List.from(_cachedPlaces),
        filteredPlaces: filtered,
        selectedGovernorate: _currentGovernorate,
        selectedCategory: _currentCategory,
      ),
    );
  }

  void searchByTitle(String query) {
    if (query.isEmpty) {
      emit(
        PlacesLoaded(
          allPlaces: List.from(_cachedPlaces),
          filteredPlaces: [],
          selectedGovernorate: _currentGovernorate,
          selectedCategory: _currentCategory,
        ),
      );
    }
    final currentState = state;
    if (currentState is! PlacesLoaded) return;

    final trimmedQuery = query.trim().toLowerCase();

    var filtered = _cachedPlaces.where((item) {
      bool govMatch =
          _currentGovernorate == "All" || item.location == _currentGovernorate;
      bool catMatch =
          _currentCategory == "All" || item.category == _currentCategory;

      bool matchesQuery = item.title.toLowerCase().contains(trimmedQuery);

      return catMatch && govMatch && matchesQuery;
    }).toList();

    emit(
      PlacesLoaded(
        allPlaces: List.from(_cachedPlaces),
        filteredPlaces: filtered,
        selectedGovernorate: _currentGovernorate,
        selectedCategory: _currentCategory,
      ),
    );
  }
}
