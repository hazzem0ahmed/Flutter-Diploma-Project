import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';


GetIt getIt = GetIt.instance;

// void configureDependenciesGetIt() {
//   // getIt.registerSingleton<Dio>(provideDio());
//   getIt.registerSingleton<ApiClient>(ApiClient(getIt()));
//   getIt.registerFactory<AuthRemoteDatasource>(
//     () => AuthRemoteDatasourceImpl(getIt()),
//   );
//   getIt.registerFactory<AuthRepo>(() => AuthRepoImpl(getIt()));
//   getIt.registerFactory<SignupUserUseCase>(() => SignupUserUseCase(getIt()));
//   getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
// }
