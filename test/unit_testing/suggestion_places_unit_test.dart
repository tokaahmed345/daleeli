import 'package:bloc_test/bloc_test.dart';
import 'package:daleeli/feature/ai_suggestions_places/domain/usecase/ai_suggestion_trips_usecase.dart';
import 'package:daleeli/feature/ai_suggestions_places/presentation/cubit/ai_suggestion_places_cubit.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAiSuggestionPlacesUsecase extends Mock
    implements AiSuggestionPlacesUsecase {}

void main() {
  late AiSuggestionPlacesCubit cubit;
  late MockAiSuggestionPlacesUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockAiSuggestionPlacesUsecase();
    cubit = AiSuggestionPlacesCubit(mockUsecase);
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state should be AiSuggestionPlacesInitial', () {
    expect(cubit.state, equals(AiSuggestionPlacesInitial()));
  });

  final tPlacesList = [
     PlacesEntity(
      id: '1',
      title: 'AI Suggested Trip',
      location: 'Cairo',
      category: 'Adventure',
      subtitle: 'A great trip suggested by AI',
      description: 'Enjoy a wonderful tour.',
      note: 'Book in advance',
      rating: 4.9,
      imageUrl: '',
      openingHours: '',
      entryFee: '',
    ),
  ];

  const tErrorMessage = 'Failed to fetch AI suggestions';

  blocTest<AiSuggestionPlacesCubit, AiSuggestionPlacesState>(
    'emits [AiSuggestionPlacesLoading, AiSuggestionPlacesSuccess] when getSuggestionsTrips is successful',
    build: () {
      when(() => mockUsecase.getSuggestionTrips())
          .thenAnswer((_) async => Right(tPlacesList));
      return cubit;
    },
    act: (cubit) => cubit.getSuggestionsTrips(),
    expect: () => [
      AiSuggestionPlacesLoading(),
      AiSuggestionPlacesSuccess(trips: tPlacesList),
    ],
  );

  blocTest<AiSuggestionPlacesCubit, AiSuggestionPlacesState>(
    'emits [AiSuggestionPlacesLoading, AiSuggestionPlacesFailure] when getSuggestionsTrips fails',
    build: () {
      when(() => mockUsecase.getSuggestionTrips())
          .thenAnswer((_) async => const Left(tErrorMessage));
      return cubit;
    },
    act: (cubit) => cubit.getSuggestionsTrips(),
    expect: () => [
      AiSuggestionPlacesLoading(),
      const AiSuggestionPlacesFailure(meessage: tErrorMessage),
    ],
  );
}