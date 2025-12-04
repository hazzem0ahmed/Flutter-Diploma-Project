import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      await Future.delayed(const Duration(seconds: 3));

      if (event.email == 'movie@gmail.com' && event.password == 'password') {
        emit(LoginSuccess());
      } else {
        emit(const LoginFailure(error: 'Error'));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
