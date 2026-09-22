
import 'package:daleeli/core/utils/failure/failure.dart';
import 'package:daleeli/feature/auth/data/data_source/login/login_firebase_remote_data_source.dart';

import 'package:daleeli/feature/auth/domain/entity/login_entity.dart';
import 'package:daleeli/feature/auth/domain/repo/login_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepoImpl implements LoginRepo {
  final LoginFirebaseRemoteDataSource remoteDataSource;

  LoginRepoImpl({required this.remoteDataSource});



  @override
  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );

      return right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.fromFirebaseAuthCode(e.code));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }
}
