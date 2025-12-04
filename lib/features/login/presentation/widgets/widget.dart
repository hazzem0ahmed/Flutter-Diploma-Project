import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../presentation/widgets/elevated_button/elevated_button.dart';
import '../../../../presentation/widgets/elevated_button/google_button.dart';
import '../../domain/bloc/login_bloc.dart';
import '../../domain/bloc/login_event.dart';
import '../../domain/bloc/login_state.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    final currentState = context.watch<LoginBloc>().state;
    final bool isLoading = currentState is LoginLoading;

    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Image.asset('assets/images/app_logo.png', height: 200, width: 200),
          SizedBox(height:20),
          _buildInputField(_emailController, 'Email', Icons.email, false),
          SizedBox(height: 16),
          _buildInputField(_passwordController, 'Password', Icons.lock, true),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Forget Password ?',
                style: TextStyle(color: Color(0xfff6BD00), fontSize: 12),
              ),
            ),
          ),
          SizedBox(height: 10),

          ElevatedButtonWidget(
            text: isLoading ? 'Loading...' : 'Login',
            onPressed: isLoading
                ? () {}
                : () {
                    loginBloc.add(
                      LoginButtonPressed(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      ),
                    );
                  },
          ),

          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Don't Have Account ?",
                style: TextStyle(color: Colors.white),
              ),

              TextButton(
                onPressed: () {},
                child: Text(
                  " Create One",
                  style: TextStyle(
                    color: Color(0xfff6BD00),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Text(
            "------------------ OR ---------------------",
            style: TextStyle(color: Color(0xfff6BD00), height: 2),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: GoogleButtonDesign(),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    TextEditingController controller,
    String label,
    IconData icon,
    bool obscure,
  ) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Color(0xff282A28),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
