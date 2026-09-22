import 'package:daleeli/core/utils/failure/failure.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:dartz/dartz.dart';


abstract class PlacesRepository {
  Future<Either<Failure, List<PlacesEntity>>> getPlaces();
}