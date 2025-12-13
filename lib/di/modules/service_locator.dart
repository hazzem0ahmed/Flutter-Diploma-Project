import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/auth/data/datasource/contract/auth_local_datasource.dart';
import 'package:movies/auth/data/datasource/impl/auth_local_datasource_impl.dart';

import '../../auth/data/datasource/contract/auth_remote_datasource.dart';
import '../../auth/data/datasource/impl/auth_remote_datasource_impl.dart';
import '../../auth/data/repo/auth_repo_impl.dart';
import '../../auth/domain/repository/auth_repository.dart';
import '../../auth/domain/use_case/signup_user_use_case.dart';
import '../../network/api_client.dart';
import '../../presentation/Register/resgister_cubit.dart';

GetIt getIt = GetIt.instance;

void configureDependenciesGetIt() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt()));
  getIt.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(getIt()),
  );
  getIt.registerFactory<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(),
  );
  getIt.registerFactory<AuthRepo>(() => AuthRepoImpl(getIt(), getIt()));
  getIt.registerFactory<SignupUserUseCase>(() => SignupUserUseCase(getIt()));

  // Correctly provide both dependencies to the RegisterCubit
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt(), getIt()));
}
