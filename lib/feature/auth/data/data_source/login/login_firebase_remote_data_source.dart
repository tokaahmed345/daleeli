import 'package:daleeli/core/utils/networking/firebase/firestore/firestore_service.dart';
import 'package:daleeli/feature/auth/data/model/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginFirebaseRemoteDataSource {
  Future<LoginModel> login({required String email, required String password});
}

class LoginFirebaseRemoteDataSourceImpl implements LoginFirebaseRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  LoginFirebaseRemoteDataSourceImpl({
    required this.firebaseAuth,
  });

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
   final userCredential = await firebaseAuth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );


  final user = LoginModel(
    id: userCredential.user!.uid,
    email: email,
  );

  return user;
  }
}