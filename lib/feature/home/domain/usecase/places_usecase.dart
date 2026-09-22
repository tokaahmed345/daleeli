import 'package:daleeli/core/utils/failure/failure.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:daleeli/feature/home/domain/repos/places_repo.dart';
import 'package:dartz/dartz.dart';


class GetPlacesUseCase {
  final PlacesRepository repository;

  GetPlacesUseCase(this.repository);

  Future<Either<Failure, List<PlacesEntity>>> fetchPlaces() async {
    return await repository.getPlaces();
  }
}