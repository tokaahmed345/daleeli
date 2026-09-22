
import 'package:daleeli/core/utils/networking/firebase/firestore/firestore_fields.dart';
import 'package:daleeli/feature/auth/domain/entity/login_entity.dart';

class LoginModel extends LoginEntity {
    final String id;

  const LoginModel({
    required super.email, required this.id,
  });

  factory LoginModel.fromMap(Map<String, dynamic> map, String id) {
    return LoginModel(
      id: id,
      email: map[FirestoreFields.email] ?? '',
    );
  }

  
}