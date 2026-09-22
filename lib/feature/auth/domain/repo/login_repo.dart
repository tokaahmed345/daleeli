import 'package:daleeli/core/utils/failure/failure.dart';
import 'package:daleeli/feature/auth/domain/entity/login_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  });
}
