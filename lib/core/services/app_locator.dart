import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/auth/data/data_sources/firebase_auth_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_firebase.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Blocs
  locator.registerFactory(() => AuthBloc(authRepository: locator()));

  // Use cases
  locator.registerLazySingleton(() => SignInWithEmailAndPassword(locator()));

  // Repositories
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryFirebase(locator()));

  // Data sources
  locator.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(firebaseAuth: locator<FirebaseAuth>()),
  );

  // External
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
}
