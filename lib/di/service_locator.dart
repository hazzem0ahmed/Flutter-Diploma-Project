import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../auth/data/datasource/contract/auth_remote_datasource.dart';
import '../auth/data/datasource/impl/auth_remote_datasource_impl.dart';
import '../auth/data/repo/auth_repo_impl.dart';
import '../auth/domain/repository/auth_repository.dart';
import '../auth/domain/use_case/signup_user_use_case.dart';
import '../network/api_client.dart';
import '../presentation/Register/resgister_cubit.dart';


GetIt getIt = GetIt.instance;

void configureDependenciesGetIt() {
  // getIt.registerSingleton<Dio>(provideDio());
  getIt.registerSingleton<ApiClient>(ApiClient(getIt()));
  getIt.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(getIt()),
  );
  getIt.registerFactory<AuthRepo>(() =>
      AuthRepoImpl(getIt(), getIt()));
  getIt.registerFactory<SignupUserUseCase>(() => SignupUserUseCase(getIt()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
}
