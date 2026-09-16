import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleeli/core/utils/networking/api_service.dart';
import 'package:daleeli/core/utils/networking/dio_consumer.dart';
import 'package:daleeli/core/utils/networking/firebase/firestore/firebase_firestore_service.dart';
import 'package:daleeli/core/utils/networking/firebase/firestore/firestore_service.dart';
import 'package:dio/dio.dart';


import 'package:firebase_auth/firebase_auth.dart';

import 'package:get_it/get_it.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;
Future<void> setupServiceLocator() async {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  // getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(() => DioConsumer(dio: getIt()));

   getIt.registerLazySingleton<FirestoreService>(
    () => FirebaseFirestoreService(
      firestore: getIt(),
    ),
  );
}
