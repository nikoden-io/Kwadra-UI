import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:kwadra/features/auth/data/data_sources/kapi_auth_data_source.dart';
import 'package:kwadra/features/auth/data/repositories/auth_repository_kapi.dart';

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
      () => AuthRepositoryKwadraApi(locator()));

  // Data sources
  locator.registerLazySingleton<KapiAuthDataSource>(
      () => KapiAuthDataSourceImpl(client: locator()));

  // External
  locator.registerLazySingleton(() => http.Client());
}
