import 'package:daleeli/core/utils/networking/firebase/firestore/firestore_collections.dart';
import 'package:daleeli/core/utils/networking/firebase/firestore/firestore_service.dart';
import 'package:daleeli/feature/auth/data/data_source/register/register_firebase_remote_data_source.dart';
import 'package:daleeli/feature/auth/data/model/register_model.dart';
import 'package:daleeli/feature/auth/data/model/register_request_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterFirebaseRemoteDataSourceImpl
    extends RegisterFirebaseRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirestoreService firestore;

  RegisterFirebaseRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<RegisterModel> register({
    required RegisterRequestModel registerModel,
  }) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: registerModel.email,
      password: registerModel.password,
    );
    final user = userCredential.user;
    final userUid = user?.uid;
    if (user != null) {
      user.updateDisplayName(registerModel.name.trim());
      user.reload();
    }
    final users = RegisterModel(
      id: userUid!,
      name: registerModel.name,
      email: registerModel.email,
    );

    final userData = registerModel.toMap();
    userData['id'] = userUid;

    await firestore.postData(
      collectionPath: FirestoreCollections.users,
      documentId: userUid,
      data: userData,
    );

    return users;
  }
}
