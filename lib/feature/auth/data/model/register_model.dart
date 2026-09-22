import 'package:daleeli/core/utils/networking/firebase/firestore/firestore_fields.dart';
import 'package:daleeli/feature/auth/domain/entity/register_entity.dart';

class RegisterModel extends RegisterEntity {
  final String id;

  RegisterModel({required super.name, required super.email, required this.id});

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      id: map[FirestoreFields.id] ?? '',
      name: map[FirestoreFields.name] ?? '',
      email: map[FirestoreFields.email] ?? '', 
 
    );
  }
}
