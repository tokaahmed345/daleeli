import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleeli/core/utils/networking/api_service.dart';
import 'package:daleeli/core/utils/networking/dio_consumer.dart';
import 'package:daleeli/core/utils/networking/firebase/firestore/firebase_firestore_service.dart';
import 'package:daleeli/core/utils/networking/firebase/firestore/firestore_service.dart';
import 'package:daleeli/feature/ai_honest_review/data/data_source/honest_remote_data_source.dart';
import 'package:daleeli/feature/ai_honest_review/data/repo_impl/honest_repo_impl.dart';
import 'package:daleeli/feature/ai_honest_review/domain/repo/honest_repo.dart';
import 'package:daleeli/feature/ai_honest_review/domain/usecase/honest_use_case.dart';
import 'package:daleeli/feature/ai_honest_review/presentation/cubit/honest_truth_cubit.dart';
import 'package:daleeli/feature/ai_suggestions_places/data/data_source/ai_suggestion_trips_remote_data_source.dart';
import 'package:daleeli/feature/ai_suggestions_places/data/repo_impl/ai_suggestion_places_repo_impl.dart';
import 'package:daleeli/feature/ai_suggestions_places/domain/repo/ai_suggestion_trips_repo.dart';
import 'package:daleeli/feature/ai_suggestions_places/domain/usecase/ai_suggestion_trips_usecase.dart';
import 'package:daleeli/feature/ai_suggestions_places/presentation/cubit/ai_suggestion_places_cubit.dart';
import 'package:daleeli/feature/auth/data/data_source/login/login_firebase_remote_data_source.dart';
import 'package:daleeli/feature/auth/data/data_source/register/register_firebase_remote_data_source.dart';
import 'package:daleeli/feature/auth/data/data_source/register/register_firebase_remote_data_source_impl.dart';
import 'package:daleeli/feature/auth/data/repo_impl/login_repo_impl.dart';
import 'package:daleeli/feature/auth/data/repo_impl/register_repo_impl.dart';
import 'package:daleeli/feature/auth/domain/repo/login_repo.dart';
import 'package:daleeli/feature/auth/domain/repo/register_repo.dart';
import 'package:daleeli/feature/auth/domain/usecase/login_use_case.dart';
import 'package:daleeli/feature/auth/domain/usecase/register_usecase.dart';
import 'package:daleeli/feature/auth/presentation/screens/login/cubit/login_cubit.dart';
import 'package:daleeli/feature/auth/presentation/screens/register/cubit/register_cubit.dart';
import 'package:daleeli/feature/home/data/data_source/places_firebase_remote_data_source.dart';
import 'package:daleeli/feature/home/data/data_source/places_firebase_remote_data_source_impl.dart';
import 'package:daleeli/feature/home/data/repo_impl.dart/places_repo_impl.dart';
import 'package:daleeli/feature/home/domain/repos/places_repo.dart';
import 'package:daleeli/feature/home/domain/usecase/places_usecase.dart';
import 'package:daleeli/feature/home/presentation/cubit/places_cubit.dart';
import 'package:daleeli/feature/saved_place/data/data_source/saved_places_firebase_remote_data_source.dart';
import 'package:daleeli/feature/saved_place/data/data_source/saved_places_firebase_remote_data_source_impl.dart';
import 'package:daleeli/feature/saved_place/data/repo_impl/saved_places_repo_impl.dart';
import 'package:daleeli/feature/saved_place/domain/repo/saved_places_repo.dart';
import 'package:daleeli/feature/saved_place/domain/usecase/saved_place_usecase.dart';
import 'package:daleeli/feature/saved_place/presentation/cubit/saved_places_cubit.dart';
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

  getIt.registerLazySingleton<FirebaseFirestoreService>(
    () => FirebaseFirestoreService(firestore: getIt()),
  );

  getIt.registerLazySingleton<FirestoreService>(
    () => getIt<FirebaseFirestoreService>(),
  );

  getIt.registerLazySingleton<RegisterFirebaseRemoteDataSource>(
    () => RegisterFirebaseRemoteDataSourceImpl(
      firebaseAuth: getIt(),
      firestore: getIt(),
    ),
  );

  getIt.registerLazySingleton<RegisterRepo>(
    () => RegisterRepoImpl(remoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(repo: getIt()),
  );

  getIt.registerLazySingleton<RegisterCubit>(
    () => RegisterCubit(useCase: getIt()),
  );

  getIt.registerLazySingleton<LoginFirebaseRemoteDataSource>(
    () => LoginFirebaseRemoteDataSourceImpl(firebaseAuth: getIt()),
  );

  getIt.registerLazySingleton<LoginRepo>(
    () => LoginRepoImpl(remoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(repo: getIt()));

  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit(getIt()));

  getIt.registerLazySingleton<PlacesFirebaseRemoteDataSource>(
    () => PlacesRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<PlacesRepository>(
    () => PlacesRepositoryImpl(remoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<GetPlacesUseCase>(
    () => GetPlacesUseCase(getIt()),
  );

  getIt.registerFactory<PlacesCubit>(() => PlacesCubit(getIt()));

  getIt.registerLazySingleton<HonestTruthRemoteDataSource>(
    () => HonestTruthRemoteDataSourceImpl(apiService: getIt()),
  );
  getIt.registerLazySingleton<HonestTruthRepository>(
    () => HonestTruthRepositoryImpl(remoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<GetHonestTruthUsecase>(
    () => GetHonestTruthUsecase(getIt()),
  );

  getIt.registerFactory<HonestTruthCubit>(
    () => HonestTruthCubit(getIt()),
  );

  getIt.registerLazySingleton<SavedPlacesFirebaseRemoteDataSource>(
    () => SavedPlacesFirebaseRemoteDataSourceImpl(firestore: getIt()),
  );
  getIt.registerLazySingleton<SavedPlacesRepository>(
    () => SavedPlacesRepoImpl(remoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<SavedPlaceUseCase>(
    () => SavedPlaceUseCase(getIt()),
  );

  getIt.registerFactory<SavedPlacesCubit>(
    () => SavedPlacesCubit(getIt()),
  );

  getIt.registerLazySingleton<AiSuggestionTripsRemoteDataSource>(
    () => AiSuggestionTripsRemoteDataSourceImpl(
      apiService: getIt(),
      firestore: getIt(),
    ),
  );

  getIt.registerLazySingleton<AiSuggestionPlacesRepo>(
    () => AiSuggestionPlacesRepoImpl(tripsRemoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<AiSuggestionPlacesUsecase>(
    () => AiSuggestionPlacesUsecase(trips: getIt()),
  );

  getIt.registerFactory<AiSuggestionPlacesCubit>(
    () => AiSuggestionPlacesCubit(getIt()),
  );
}
