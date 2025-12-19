import 'package:injectable/injectable.dart';

import '../../../network/results.dart';
import '../repository/auth_repository.dart';

@injectable
class SignupUserUseCase {
  AuthRepo authRepo;

  SignupUserUseCase(this.authRepo);

  Future<Results<String>> signUp(
    String name,
    String email,
    String password,
    String rePassword,
  ) {
    return authRepo.signUp(name, email, password, rePassword);
  }
}
