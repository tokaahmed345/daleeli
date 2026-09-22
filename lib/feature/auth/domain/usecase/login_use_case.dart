import 'package:daleeli/core/utils/failure/failure.dart';
import 'package:daleeli/feature/auth/domain/entity/login_entity.dart';
import 'package:daleeli/feature/auth/domain/repo/login_repo.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final LoginRepo repo;

  LoginUseCase({required this.repo});

  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  }) async {
    return await repo.login(email: email, password: password);
  }
}
