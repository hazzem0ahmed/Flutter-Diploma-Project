import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/presentation/Register/resgister_contract.dart';
import 'package:movies/presentation/Register/resgister_cubit.dart';
import 'package:movies/presentation/widgets/language/language_switch.dart';
import '../../core/app_asset.dart';
import '../../di/modules/service_locator.dart';
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
  var phoneController = TextEditingController();

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
          CherryToast.error(
            title: Text(
              navigationState.errorMessage,
              style: const TextStyle(color: Colors.black),
            ),
          ).show(context);

        case NavigateToLogin():
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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
            onTap:
                () => Navigator.pushReplacementNamed(
                  context,
                  LoginScreen.routeName,
                ),
            child: Icon(Icons.arrow_back, color: AppColors.white),
          ),
          title: Text(
            AppLocalizations.of(context)!.createAccount,
            style: TextStyle(color: AppColors.white),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),

                // ========== Avatars ==========
                _buildAvatars(),
                const SizedBox(height: 25),

                // ========== Inputs ==========
                _inputField(
                  label: AppLocalizations.of(context)!.name,
                  icon: Icons.badge_outlined,
                  controller: nameController,
                ),
                const SizedBox(height: 12),

                _inputField(
                  label: AppLocalizations.of(context)!.email,
                  icon: Icons.email_outlined,
                  controller: emailController,
                ),
                const SizedBox(height: 12),

                _inputField(
                  label: AppLocalizations.of(context)!.password,
                  icon: Icons.lock_outline,
                  controller: passwordController,
                  obscure: !showPassword,
                  suffix: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white70,
                    ),
                    onPressed:
                        () => setState(() => showPassword = !showPassword),
                  ),
                ),
                const SizedBox(height: 12),

                _inputField(
                  label: AppLocalizations.of(context)!.confirmPassword,
                  icon: Icons.lock_outline,
                  controller: passwordConfirmationController,
                  obscure: !showConfirmPassword,
                  suffix: IconButton(
                    icon: Icon(
                      showConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white70,
                    ),
                    onPressed:
                        () => setState(
                          () => showConfirmPassword = !showConfirmPassword,
                        ),
                  ),
                ),
                const SizedBox(height: 12),

                _inputField(
                  label: AppLocalizations.of(context)!.phoneNumber,
                  icon: Icons.phone_outlined,
                  controller: phoneController,
                ),
                const SizedBox(height: 25),

                // ========== Register Button ==========
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return ElevatedButton(
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
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                        ),
                        child:
                            state.loginResources.status == Status.loading
                                ? CircularProgressIndicator()
                                : Text(
                                  AppLocalizations.of(context)!.login,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: AppColors.white),
                                ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // ========== Login Link ==========
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.alreadyHaveAccount,
                      style: TextStyle(color: AppColors.white),
                    ),
                    const SizedBox(width: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          LoginScreen.routeName,
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                const LanguageSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========== Avatars ==========
  Widget _buildAvatars() {
    List<String> avatars = [
      AppAsset.avatar1,
      AppAsset.avatar2,
      AppAsset.avatar3,
      AppAsset.avatar4,
      AppAsset.avatar5,
      AppAsset.avatar6,
      AppAsset.avatar7,
      AppAsset.avatar8,
      AppAsset.avatar9,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(avatars.length, (index) {
          return GestureDetector(
            onTap: () => setState(() => selectedAvatar = index),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      selectedAvatar == index
                          ? Colors.blue
                          : Colors.transparent,
                  width: 3,
                ),
              ),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(avatars[index]),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ========== Input Field ==========
  Widget _inputField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool obscure = false,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: AppColors.white),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "هذا الحقل مطلوب";
          }
          return null;
        },
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
