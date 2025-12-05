import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/presentation/Register/resgister_contract.dart';
import 'package:movies/presentation/Register/resgister_cubit.dart';
import 'package:movies/presentation/widgets/language/language_switch.dart';
import '../../core/app_asset.dart';
import '../../di/di.dart';
import '../../features/login/presentation/pages/login_screen.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../network/resources.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();

}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmationController = TextEditingController();
   RegisterCubit cubit = getIt();
  var formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool showConfirmPassword = false;
  int selectedAvatar = -1;

  @override
  void initState() {
    super.initState();
    cubit.navigation.listen((navigationState) {
      switch (navigationState) {
        case ShowRegisterErrorToast():
          {
            CherryToast.error(
              title: Text(
                navigationState.errorMessage,
                style: const TextStyle(color: Colors.black),
              ),
            ).show(context);
          }
        case NavigateToLogin():{

        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => cubit,
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back, color: AppColors.white)),
          title:  Text(
            AppLocalizations.of(context)!.createAccount,
            style: TextStyle(color: AppColors.white),
          ),
        ),
      
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // -------- Avatar 1 --------
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = 0;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedAvatar == 0 ? Colors.blue : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(AppAsset.avatar1
                          ),
                        ),
                      ),
                    ),
                
                    // -------- Avatar 2 --------
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = 1;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedAvatar == 1 ? Colors.blue : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(AppAsset.avatar2),
                        ),
                      ),
                    ),
                
                    // -------- Avatar 3 --------
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = 2;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedAvatar == 2 ? Colors.blue : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(AppAsset.avatar3),
                        ),
                      ),
                    ),
                    // -------- Avatar 4 --------
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = 3;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedAvatar == 0 ? Colors.blue : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(AppAsset.avatar4
                          ),
                        ),
                      ),
                    ),
                
                    // -------- Avatar 5 --------
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = 4;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedAvatar == 1 ? Colors.blue : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(AppAsset.avatar5),
                        ),
                      ),
                    ),
                
                    // -------- Avatar 6 --------
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = 5;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedAvatar == 2 ? Colors.blue : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(AppAsset.avatar6),
                        ),
                      ),
                    ),
                    // -------- Avatar 7 --------
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = 6;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedAvatar == 0 ? Colors.blue : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(AppAsset.avatar7
                          ),
                        ),
                      ),
                    ),
                
                    // -------- Avatar 8 --------
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = 7;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedAvatar == 1 ? Colors.blue : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(AppAsset.avatar8),
                        ),
                      ),
                    ),
                
                    // -------- Avatar 9 --------
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = 8;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedAvatar == 2 ? Colors.blue : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(AppAsset.avatar9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
      
              // --- Name ---
              _inputField(
                label: AppLocalizations.of(context)!.name,
                icon: Icons.badge_outlined,
              ),
              const SizedBox(height: 12),
      
              // --- Email ---
              _inputField(
                label: AppLocalizations.of(context)!.email,
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 12),
      
              // --- Password ---
              _inputField(
                label: AppLocalizations.of(context)!.password,
                icon: Icons.lock_outline,
                obscure: !showPassword,
                suffix: IconButton(
                  icon: Icon(
                    showPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white70,
                  ),
                  onPressed: () =>
                      setState(() => showPassword = !showPassword),
                ),
              ),
              const SizedBox(height: 12),
      
              // --- Confirm Password ---
              _inputField(
                label: AppLocalizations.of(context)!.confirmPassword,
                icon: Icons.lock_outline,
                obscure: !showConfirmPassword,
                suffix: IconButton(
                  icon: Icon(
                    showConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white70,
                  ),
                  onPressed: () =>
                      setState(() => showConfirmPassword = !showConfirmPassword),
                ),
              ),
              const SizedBox(height: 12),
      
              // --- Phone Number ---
              _inputField(
                label: AppLocalizations.of(context)!.phoneNumber,
                icon: Icons.phone_outlined,
              ),
              const SizedBox(height: 25),
      
              // --- Create Account Button ---
              SizedBox(
                width: double.infinity,
                height: 55,
                child:  BlocBuilder<RegisterCubit, RegisterState>(
                  builder:
                      (context, state) => ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.doAction(
                          RegisterUserAction(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                            passwordConfirmationController.text,
                          ),
                        );
                        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellow,
                    ),
                    child:
                    state.loginResources.status == Status.loading
                        ? const CircularProgressIndicator()
                        : Text(
                      AppLocalizations.of(context)!.login,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                ),
      
              ),
      
              const SizedBox(height: 20),
      
              // --- Login Link ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(AppLocalizations.of(context)!.alreadyHaveAccount,
                      style: TextStyle(color: AppColors.white)),
                  SizedBox(width: 5),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    },
                    child: Text(
                                        AppLocalizations.of(context)!.login,
                                        style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold),
                                      )
                  )
                ],
              ),
      
              const SizedBox(height: 20),
      
              const LanguageSwitch(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required String label,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        obscureText: obscure,
        style: const TextStyle(color: AppColors.white),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          prefixIcon: Icon(icon, color: Colors.white70),
          hintText: label,
          hintStyle: const TextStyle(color: Colors.white54),
          suffixIcon: suffix,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
