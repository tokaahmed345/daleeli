import 'package:bloc_test/bloc_test.dart';
import 'package:daleeli/core/utils/failure/failure.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:daleeli/feature/home/domain/usecase/places_usecase.dart';
import 'package:daleeli/feature/home/presentation/cubit/places_cubit.dart';
import 'package:daleeli/feature/home/presentation/cubit/places_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPlacesUseCase extends Mock implements GetPlacesUseCase {}

void main() {
  late PlacesCubit placesCubit;
  late MockGetPlacesUseCase mockGetPlacesUseCase;

  setUp(() {
    mockGetPlacesUseCase = MockGetPlacesUseCase();
    placesCubit = PlacesCubit(mockGetPlacesUseCase);
  });

  tearDown(() {
    placesCubit.close();
  });

  test('initial state should be PlacesInitial', () {
    expect(placesCubit.state, equals(PlacesInitial()));
  });

  final tPlacesList = [
     PlacesEntity(
id: '1',
      title: 'Cairo Tower',
      location: 'Matrouh',
      category: 'Landmark',
      subtitle: 'A famous tower in Cairo',
      description: 'Tall modern tower offering panoramic views of the city.',
      note: 'Best visited at sunset.',
      rating: 4.5,
      imageUrl: 'https://example.com/cairo_tower.png',
      openingHours: '9:00 AM - 11:00 PM',
      entryFee: '200 EGP',
    ),
     PlacesEntity(
id: '1',
      title: 'Cairo Tower',
      location: 'Matrouh',
      category: 'Landmark',
      subtitle: 'A famous tower in Cairo',
      description: 'Tall modern tower offering panoramic views of the city.',
      note: 'Best visited at sunset.',
      rating: 4.5,
      imageUrl: 'https://example.com/cairo_tower.png',
      openingHours: '9:00 AM - 11:00 PM',
      entryFee: '200 EGP',
    ),
  ];

  blocTest<PlacesCubit, PlacesState>(
    'emits [PlacesLoading, PlacesLoaded] when fetchPlaces is successful',
    build: () {
      when(() => mockGetPlacesUseCase.fetchPlaces())
          .thenAnswer((_) async => Right(tPlacesList));
      return placesCubit;
    },
    act: (cubit) => cubit.fetchPlaces(),
    expect: () => [
      PlacesLoading(),
      PlacesLoaded(
        allPlaces: tPlacesList,
        filteredPlaces: tPlacesList,
        selectedGovernorate: "All",
        selectedCategory: "All",
      ),
    ],
  );

  blocTest<PlacesCubit, PlacesState>(
    'emits [PlacesLoading, PlacesError] when fetchPlaces fails',
    build: () {
      when(() => mockGetPlacesUseCase.fetchPlaces())
          .thenAnswer((_) async =>  Left(Failure('Server Error')));
      return placesCubit;
    },
    act: (cubit) => cubit.fetchPlaces(),
    expect: () => [
      PlacesLoading(),
      const PlacesError('Server Error'),
    ],
  );

  blocTest<PlacesCubit, PlacesState>(
    'filters places correctly by governorate',
    build: () {
      when(() => mockGetPlacesUseCase.fetchPlaces())
          .thenAnswer((_) async => Right(tPlacesList));
      return placesCubit;
    },
    act: (cubit) async {
    await  cubit.fetchPlaces();
      cubit.filterByGovernorate('Matrouh');
    },
    expect: () => [
      PlacesLoading(),
      PlacesLoaded(
        allPlaces: tPlacesList,
        filteredPlaces: tPlacesList,
        selectedGovernorate: "All",
        selectedCategory: "All",
      ),
      PlacesLoaded(
        allPlaces: tPlacesList,
        filteredPlaces: tPlacesList,
        selectedGovernorate: "Matrouh",
        selectedCategory: "All",
      ),
    ],
  );
}