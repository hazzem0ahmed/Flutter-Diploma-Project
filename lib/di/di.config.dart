// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;


import '../../network/api_client.dart' as _i972;
import '../auth/data/datasource/contract/auth_local_datasource.dart' as _i1071;
import '../auth/data/datasource/contract/auth_remote_datasource.dart' as _i1070;
import '../auth/data/repo/auth_repo_impl.dart' as _i984;
import '../auth/domain/repository/auth_repository.dart' as _i961;
import '../auth/domain/use_case/signup_user_use_case.dart' as _i529;
import '../presentation/Register/resgister_cubit.dart' as _i837;
import 'modules/shared_preferences_module.dart' as _i813;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferencesModule = _$SharedPreferencesModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.provideSharedPreferences(),
      preResolve: true,
    );

    gh.factory<_i961.AuthRepo>(
      () => _i984.AuthRepoImpl(
        gh<_i1070.AuthRemoteDatasource>(),
        gh<_i1071.AuthLocalDatasource>(),
      ),
    );

    gh.factory<_i529.SignupUserUseCase>(
      () => _i529.SignupUserUseCase(gh<_i961.AuthRepo>()),
    );
    gh.factory<_i837.RegisterCubit>(
      () => _i837.RegisterCubit(gh<_i529.SignupUserUseCase>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i813.SharedPreferencesModule {}

