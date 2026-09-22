import 'package:daleeli/core/utils/networking/firebase/firestore/firestore_fields.dart';

class RegisterRequestModel {
  final String name;
  final String email;
   String? id;
  final String password;

  RegisterRequestModel({required this.name, required this.email,  this.id, required this.password});

  Map<String, dynamic> toMap() {
    return {FirestoreFields.id: id, FirestoreFields.name: name, FirestoreFields.email: email};
  }
}
