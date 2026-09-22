import 'package:daleeli/core/utils/failure/failure.dart';
import 'package:daleeli/feature/home/data/data_source/places_firebase_remote_data_source.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:daleeli/feature/home/domain/repos/places_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';


class PlacesRepositoryImpl implements PlacesRepository {
  final PlacesFirebaseRemoteDataSource remoteDataSource;

PlacesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PlacesEntity>>> getPlaces() async {
    try {
      final placesModels = await remoteDataSource.getPlaces();
      return Right(placesModels); 
    } on FirebaseException catch (e) {
      return Left(Failure.fromFirebaseAuthCode(e.code));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }
}