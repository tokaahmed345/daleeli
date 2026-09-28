import 'package:bloc_test/bloc_test.dart';
import 'package:daleeli/feature/ai_honest_review/domain/entity/honest_entity.dart';
import 'package:daleeli/feature/ai_honest_review/domain/usecase/honest_use_case.dart';
import 'package:daleeli/feature/ai_honest_review/presentation/cubit/honest_truth_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetHonestTruthUsecase extends Mock implements GetHonestTruthUsecase {}

void main() {
  late HonestTruthCubit cubit;
  late MockGetHonestTruthUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockGetHonestTruthUsecase();
    cubit = HonestTruthCubit(mockUsecase);
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state should be HonestTruthInitial', () {
    expect(cubit.state, equals(HonestTruthInitial()));
  });

  const tPlaceName = 'Cairo Tower';
  const tPlaceDescription = 'A nice place to visit';
  
   final tHonestEntity = HonestTruthEntity(
    vibeSummary: '', bulletPoints: [],
  );

  const tErrorMessage = 'Failed to fetch review';

  blocTest<HonestTruthCubit, HonestTruthState>(
    'emits [HonestTruthLoading, HonestTruthLoaded] when fetchHonestTruth is successful',
    build: () {
      when(() => mockUsecase.getTruth(
            placeName: any(named: 'placeName'),
            placeDescription: any(named: 'placeDescription'),
          )).thenAnswer((_) async =>  Right(tHonestEntity));
      return cubit;
    },
    act: (cubit) => cubit.fetchHonestTruth(
      placeName: tPlaceName,
      placeDescription: tPlaceDescription,
    ),
    expect: () => [
      HonestTruthLoading(),
       HonestTruthLoaded(tHonestEntity),
    ],
  );

  blocTest<HonestTruthCubit, HonestTruthState>(
    'emits [HonestTruthLoading, HonestTruthError] when fetchHonestTruth fails',
    build: () {
      when(() => mockUsecase.getTruth(
            placeName: any(named: 'placeName'),
            placeDescription: any(named: 'placeDescription'),
          )).thenAnswer((_) async => const Left(tErrorMessage));
      return cubit;
    },
    act: (cubit) => cubit.fetchHonestTruth(
      placeName: tPlaceName,
      placeDescription: tPlaceDescription,
    ),
    expect: () => [
      HonestTruthLoading(),
      const HonestTruthError(tErrorMessage),
    ],
  );
}