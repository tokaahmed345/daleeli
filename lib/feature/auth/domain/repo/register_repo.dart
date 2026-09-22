import 'package:daleeli/core/utils/failure/failure.dart';
import 'package:daleeli/feature/auth/data/model/register_request_model.dart';
import 'package:daleeli/feature/auth/domain/entity/register_entity.dart';
 import 'package:dartz/dartz.dart';


abstract class RegisterRepo{
  Future<Either<Failure,RegisterEntity>>register({    required RegisterRequestModel registerRequetModel,
});
 }
  
