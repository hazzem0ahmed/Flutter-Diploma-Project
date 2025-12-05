import '../../../network/results.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/contract/auth_local_datasource.dart';
import '../datasource/contract/auth_remote_datasource.dart';
import '../models/auth_response_dto.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRemoteDatasource remoteDatasource;
  AuthLocalDatasource localDatasource;
  AuthRepoImpl(this.remoteDatasource, this.localDatasource);

  @override
  Future<Results<String>> signUp(
    String name,
    String email,
    String password,
    String rePassword,
  ) async {
    var response = await remoteDatasource.signUp(
      email,
      name,
      password,
      rePassword,
    );
    return switch (response) {
      Success<AuthResponseDto>() => Success(response.data?.token),
      Failure<AuthResponseDto>() => Failure(
          response.exception,
          response.message,
        ),
    };
  }

  @override
  Future<Results<String>> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
