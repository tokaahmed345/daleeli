import 'package:daleeli/core/utils/failure/failure.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:daleeli/feature/saved_place/data/data_source/saved_places_firebase_remote_data_source.dart';
import 'package:daleeli/feature/saved_place/domain/repo/saved_places_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SavedPlacesRepoImpl implements SavedPlacesRepository {
  final SavedPlacesFirebaseRemoteDataSource remoteDataSource;

  SavedPlacesRepoImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<PlacesEntity>>> getSavedPlaces() async {
    try {
      final getSavedPlaces = await remoteDataSource.getSavedPlaces();
      return right(getSavedPlaces);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.fromFirebaseAuthCode(e.code));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> removeSavedPlace(String placeId) async {
    try {
      final removedItem = await remoteDataSource.removePlace(placeId);
      return right(removedItem);
    } on FirebaseException catch (e) {
      return Left(Failure.fromFirebaseAuthCode(e.code));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> savePlace(PlacesEntity place) async {
    try {
      final savedItem = await remoteDataSource.savePlace(place);
      return right(savedItem);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.fromFirebaseAuthCode(e.code));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }
}
