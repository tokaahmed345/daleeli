import 'package:daleeli/core/utils/failure/failure.dart';
import 'package:daleeli/feature/auth/data/data_source/register/register_firebase_remote_data_source.dart';
import 'package:daleeli/feature/auth/data/model/register_request_model.dart';
import 'package:daleeli/feature/auth/domain/entity/register_entity.dart';
import 'package:daleeli/feature/auth/domain/repo/register_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepoImpl implements RegisterRepo {
  final RegisterFirebaseRemoteDataSource remoteDataSource;

  RegisterRepoImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, RegisterEntity>> register({
    required RegisterRequestModel registerRequetModel,
  }) async {
    try {
      final user = await remoteDataSource.register(
        registerModel: registerRequetModel,
      );

      return right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.fromFirebaseAuthCode(e.code));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }
}