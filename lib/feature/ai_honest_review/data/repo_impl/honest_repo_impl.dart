import 'package:daleeli/feature/ai_honest_review/data/data_source/honest_remote_data_source.dart';
import 'package:daleeli/feature/ai_honest_review/domain/entity/honest_entity.dart';
import 'package:daleeli/feature/ai_honest_review/domain/repo/honest_repo.dart';
import 'package:dartz/dartz.dart';


class HonestTruthRepositoryImpl implements HonestTruthRepository {
  final HonestTruthRemoteDataSource remoteDataSource;

  HonestTruthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, HonestTruthEntity>> getHonestTruth({
    required String placeName,
    required String placeDescription,
  }) async {
    try {
      final model = await remoteDataSource.fetchHonestTruth(
        placeName: placeName,
        placeDescription: placeDescription,
      );
      return Right(model);
    } catch (e) {
      return Left(e.toString());
    }
  }
}