import 'package:injectable/injectable.dart';
import 'package:movies/auth/data/datasource/contract/auth_local_datasource.dart';
import 'package:movies/presentation/Register/resgister_contract.dart';
import '../../auth/domain/use_case/signup_user_use_case.dart';
import '../../base/base_cubit.dart';
import '../../network/resources.dart';
import '../../network/results.dart';

@injectable
class RegisterCubit
    extends BaseCubit<RegisterState, RegisterAction, RegisterNavigationAction> {
  SignupUserUseCase useCase;
  AuthLocalDatasource localDatasource;

  RegisterCubit(this.useCase, this.localDatasource)
      : super(RegisterState());

  @override
  Future<void> doAction(RegisterAction action) async {
    switch (action) {
      case RegisterUserAction():
        {
          await _register(action);
        }
    }
  }

  Future<void> _register(RegisterUserAction action) async {
    emit(state.copyWith(loginResources: const Resources.loading()));
    var response = await useCase.signUp(
      action.name,
      action.email,
      action.password,
      action.rePassword,
    );
    switch (response) {
      case Success<String>():
        {
          await localDatasource.saveToken(response.data!); 
          await localDatasource.saveUserName(action.name);

          emit(
            state.copyWith(
              loginResources: Resources.success(data: response.data),
            ),
          );
          emitNavigation(NavigateToLogin());
        }
      case Failure<String>():
        {
          emitNavigation(ShowRegisterErrorToast(response.message));
          emit(
            state.copyWith(
              loginResources: Resources.failure(
                exception: response.exception,
                message: response.message,
              ),
            ),
          );
        }
    }
  }
}
