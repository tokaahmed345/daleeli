import 'package:bloc/bloc.dart';
import 'package:daleeli/feature/ai_honest_review/domain/entity/honest_entity.dart';
import 'package:daleeli/feature/ai_honest_review/domain/usecase/honest_use_case.dart';
import 'package:equatable/equatable.dart';

part 'honest_truth_state.dart';

class HonestTruthCubit extends Cubit<HonestTruthState> {

  final GetHonestTruthUsecase getHonestTruthUsecase;

  HonestTruthCubit(this.getHonestTruthUsecase) : super(HonestTruthInitial());

  Future<void> fetchHonestTruth({required String placeName, required String placeDescription}) async {
    emit(HonestTruthLoading());
    
    final result = await getHonestTruthUsecase.getTruth(
      placeName: placeName,
      placeDescription: placeDescription,
    );

    result.fold(
      (error) => emit(HonestTruthError(error)),
      (entity) => emit(HonestTruthLoaded(entity)),
    );
  }
}