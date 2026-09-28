import 'package:bloc_test/bloc_test.dart';
import 'package:daleeli/core/utils/failure/failure.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:daleeli/feature/saved_place/domain/usecase/saved_place_usecase.dart';
import 'package:daleeli/feature/saved_place/presentation/cubit/saved_places_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSavedPlaceUseCase extends Mock implements SavedPlaceUseCase {}

void main() {
  late SavedPlacesCubit savedPlacesCubit;
  late MockSavedPlaceUseCase mockSavedPlaceUseCase;

  setUp(() {
    mockSavedPlaceUseCase = MockSavedPlaceUseCase();
    savedPlacesCubit = SavedPlacesCubit(mockSavedPlaceUseCase);
  });

  tearDown(() {
    savedPlacesCubit.close();
  });

  test('initial state should be SavedPlacesInitial', () {
    expect(savedPlacesCubit.state, equals(SavedPlacesInitial()));
  });

  final tPlacesList = [
     PlacesEntity(
      id: '1',
      title: 'Cairo Tower',
      location: 'Cairo',
      category: 'Landmark',
      subtitle: 'A famous tower',
      description: 'Tall modern tower.',
      note: 'None',
      rating: 4.5,
      imageUrl: '',
      openingHours: '',
      entryFee: '',
    ),
  ];

  final tPlace = PlacesEntity(
    id: '1',
    title: 'Cairo Tower',
    location: 'Cairo',
    category: 'Landmark',
    subtitle: 'A famous tower',
    description: 'Tall modern tower.',
    note: 'None',
    rating: 4.5,
    imageUrl: '',
    openingHours: '',
    entryFee: '',
  );

  group('fetchSavedPlaces', () {
    blocTest<SavedPlacesCubit, SavedPlacesState>(
      'emits [SavedLoading, SavedPlacesLoaded] when fetching saved places is successful',
      build: () {
        when(() => mockSavedPlaceUseCase.getSavedPlaces())
            .thenAnswer((_) async => Right(tPlacesList));
        return savedPlacesCubit;
      },
      act: (cubit) => cubit.fetchSavedPlaces(),
      expect: () => [
        SavedLoading(),
        SavedPlacesLoaded(tPlacesList),
      ],
    );

    blocTest<SavedPlacesCubit, SavedPlacesState>(
      'emits [SavedLoading, SavedError] when fetching saved places fails',
      build: () {
        when(() => mockSavedPlaceUseCase.getSavedPlaces())
            .thenAnswer((_) async =>  Left(Failure('Failed to load')));
        return savedPlacesCubit;
      },
      act: (cubit) => cubit.fetchSavedPlaces(),
      expect: () => [
        SavedLoading(),
        const SavedError('Failed to load'),
      ],
    );
  });

  group('toggleSavePlace', () {
    blocTest<SavedPlacesCubit, SavedPlacesState>(
      'saves place successfully and triggers fetchSavedPlaces',
      build: () {
        when(() => mockSavedPlaceUseCase.savePlace(tPlace))
            .thenAnswer((_) async => const Right(null));
        when(() => mockSavedPlaceUseCase.getSavedPlaces())
            .thenAnswer((_) async => Right(tPlacesList));
        return savedPlacesCubit;
      },
      act: (cubit) => cubit.toggleSavePlace(tPlace, false),
      expect: () => [
        SavedLoading(), 
        SavedPlacesLoaded(tPlacesList),
      ],
    );

    blocTest<SavedPlacesCubit, SavedPlacesState>(
      'removes place successfully and triggers fetchSavedPlaces',
      build: () {
        when(() => mockSavedPlaceUseCase.removePlace(tPlace.id))
            .thenAnswer((_) async => const Right(null));
        when(() => mockSavedPlaceUseCase.getSavedPlaces())
            .thenAnswer((_) async => const Right([])); 
        return savedPlacesCubit;
      },
      act: (cubit) => cubit.toggleSavePlace(tPlace, true), 
      expect: () => [
        SavedLoading(),
        const SavedPlacesLoaded([]),
      ],
    );
  });
}