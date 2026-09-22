import 'package:bloc/bloc.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:daleeli/feature/saved_place/domain/usecase/saved_place_usecase.dart';
import 'package:equatable/equatable.dart';

part 'saved_places_state.dart';

class SavedPlacesCubit extends Cubit<SavedPlacesState> {
  final SavedPlaceUseCase savedPlacesUseCase;

  SavedPlacesCubit(this.savedPlacesUseCase) : super(SavedPlacesInitial());

  Future<void> toggleSavePlace(
    PlacesEntity place,
    bool isCurrentlySaved,
  ) async {
    if (isClosed) return;

    if (isCurrentlySaved) {
      final result = await savedPlacesUseCase.removePlace(place.id);

      if (isClosed) return;

      result.fold(
        (failure) {
          if (!isClosed) emit(SavedError(failure.message));
        },
        (_) {
          place.isSaved = false;
          // ✅ التعديل الوحيد هنا: بدل SavedItemSuccess (state مش متعرف
          // في الشاشة)، بنعمل fetchSavedPlaces() تاني عشان القائمة
          // تتحدث فورًا وترجع state معروف (Loaded).
          fetchSavedPlaces();
        },
      );
    } else {
      final result = await savedPlacesUseCase.savePlace(place);

      if (isClosed) return;

      result.fold(
        (failure) {
          if (!isClosed) emit(SavedError(failure.message));
        },
        (_) {
          place.isSaved = true;
          fetchSavedPlaces();
        },
      );
    }
  }

  Future<void> fetchSavedPlaces() async {
    if (isClosed) return;
    emit(SavedLoading());

    final result = await savedPlacesUseCase.getSavedPlaces();

    if (isClosed) return;

    result.fold(
      (failure) {
        if (!isClosed) emit(SavedError(failure.message));
      },
      (places) {
        if (!isClosed) emit(SavedPlacesLoaded(places));
      },
    );
  }
}