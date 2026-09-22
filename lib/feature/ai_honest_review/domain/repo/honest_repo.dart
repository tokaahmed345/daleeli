import 'package:daleeli/feature/ai_honest_review/domain/entity/honest_entity.dart';
import 'package:dartz/dartz.dart'; 

abstract class HonestTruthRepository {
  Future<Either<String, HonestTruthEntity>> getHonestTruth({
    required String placeName,
    required String placeDescription,
  });
}