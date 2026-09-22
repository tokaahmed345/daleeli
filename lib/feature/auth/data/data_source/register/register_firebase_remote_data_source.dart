import 'package:daleeli/feature/auth/data/model/register_model.dart';
import 'package:daleeli/feature/auth/data/model/register_request_model.dart';

abstract class RegisterFirebaseRemoteDataSource {
  Future<RegisterModel> register({
required RegisterRequestModel registerModel,
  });
}
