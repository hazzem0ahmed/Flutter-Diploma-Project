import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/bloc/login_bloc.dart';
import '../../domain/bloc/login_state.dart';
import '../widgets/widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Color(0xff121312),
        body: Center(child: SingleChildScrollView(child: LoginView())),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  static const String homeRoute = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          _showSnackBar(context, 'Done');
          Navigator.of(context).pushReplacementNamed(homeRoute);
        } else if (state is LoginFailure) {
          _showSnackBar(context, 'Error ${state.error}');
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return LoginFormWidget();
        },
      ),
    );
  }
}
