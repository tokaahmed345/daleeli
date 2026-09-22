import 'package:daleeli/feature/ai_honest_review/domain/entity/honest_entity.dart';
import 'package:daleeli/feature/ai_honest_review/domain/repo/honest_repo.dart';
import 'package:dartz/dartz.dart';

class GetHonestTruthUsecase {
  final HonestTruthRepository repository;

  GetHonestTruthUsecase(this.repository);

  Future<Either<String, HonestTruthEntity>> getTruth({
    required String placeName,
    required String placeDescription,
  }) async {
    return await repository.getHonestTruth(
      placeName: placeName,
      placeDescription: placeDescription,
    );
  }
}