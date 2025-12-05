import 'package:injectable/injectable.dart';

import '../../../../network/api_client.dart';
import '../../../../network/app_exceptions.dart';
import '../../../../network/results.dart';
import '../../../../network/safe_call.dart';
import '../../models/auth_response_dto.dart';
import '../../models/register_request_dto.dart';
import '../contract/auth_remote_datasource.dart';

@Injectable(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  ApiClient apiClient;

  AuthRemoteDatasourceImpl(this.apiClient);

  @override
  Future<Results<AuthResponseDto>> signUp(
    String email,
    String name,
    String password,
    String rePassword,
  ) async {
    return safeCall(() async {
      var registerRequest = RegisterRequestDto(
        name: name,
        email: email,
        password: password,
        rePassword: rePassword,
      );
      var response = await apiClient.signUp(registerRequest);
      if (response.statusMsg != null) {
        return Failure(AuthException(), response.message ?? "");
      }
      return Success(response);
    });
  }

  @override
  Future<Results<AuthResponseDto>> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }


}
