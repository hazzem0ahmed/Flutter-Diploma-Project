
import '../../../../../network/results.dart';
import '../../models/auth_response_dto.dart';

abstract interface class AuthRemoteDatasource {

  Future<Results<AuthResponseDto>> signUp(String email, String name,
      String password, String rePassword);

  Future<Results<AuthResponseDto>> login(String email , String password);

}