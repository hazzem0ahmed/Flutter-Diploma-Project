import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/auth/data/datasource/contract/auth_local_datasource.dart';
import 'package:movies/core/app_extensions.dart';
import 'package:movies/di/modules/service_locator.dart';
import 'package:movies/features/login/presentation/pages/login_screen.dart';
import 'package:movies/presentation/screens/tabs/edit_profile/edit_profile_contract.dart';
import 'package:movies/presentation/screens/tabs/edit_profile/edit_profile_view_model.dart';
import '../../../../core/app_colors.dart';
import '../../../../firebase/google_auth.dart';
import '../../../widgets/data.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = "/editProfile";

  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late EditProfileViewModel viewModel;

  //TextFormFieldControllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String selectedAvatar = AvatarData.avatarList[0].imagePath;

  @override
  void initState() {
    super.initState();
    viewModel = EditProfileViewModel();
    _loadUserData();
  }

  @override
  void dispose() {
    viewModel.close();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final localDataSource = getIt<AuthLocalDatasource>();
    final name = await localDataSource.getUserName();
    final phone = FirebaseAuth.instance.currentUser?.phoneNumber;

    if (mounted) {
      setState(() {
        nameController.text =
            name ?? FirebaseAuth.instance.currentUser?.displayName ?? "";
        phoneController.text = phone ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_outlined, size: 30),
        ),
        foregroundColor: AppColors.yellow,
        backgroundColor: Colors.transparent,
        title: Text(context.locale.editProfile),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: context.spaceHeight * 0.03),
            Center(
              child: GestureDetector(
                onTap: () {
                  showModalSheet(context);
                },
                child: BlocBuilder<EditProfileViewModel, EditProfileState>(
                  bloc: viewModel,
                  builder: (context, state) {
                    return ClipOval(
                      child: Image.asset(
                        state.selectedAvatar,
                        width: context.spaceWidth * 0.45,
                        height: context.spaceWidth * 0.45,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: context.spaceHeight * 0.05),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: nameController,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    decoration: _inputDecoration(
                      hint: context.locale.name,
                      icon: Icons.person,
                    ),
                  ),
                  SizedBox(height: context.spaceHeight * 0.03),
                  TextFormField(
                    controller: phoneController,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    decoration: _inputDecoration(
                      hint: context.locale.phoneNumber,
                      icon: Icons.phone,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.spaceHeight * 0.02),
            Text(
              context.locale.resetPassword,
              style: context.text.titleMedium!.copyWith(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: context.spaceHeight * 0.2),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    try {
                      final googleAuth = FirebaseAuthServices();
                      googleAuth.deleteGoogleAccount();
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    } catch (e) {
                      CherryToast.error(
                        description: Text(e.toString()),
                      ).show(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    fixedSize: Size(
                      context.spaceWidth * 0.99,
                      context.spaceHeight * 0.07,
                    ),
                  ),
                  child: Text(
                    context.locale.deleteAccount,
                    style: context.text.titleMedium!.copyWith(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: context.spaceHeight * 0.01),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    fixedSize: Size(
                      context.spaceWidth * 0.99,
                      context.spaceHeight * 0.07,
                    ),
                  ),
                  child: Text(
                    context.locale.updateData,
                    style: context.text.titleMedium!.copyWith(
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: AppColors.white),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(width: 1, color: AppColors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(width: 1, color: AppColors.grey),
      ),
      enabled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(width: 1, color: AppColors.grey),
      ),
      filled: true,
      fillColor: AppColors.grey.withAlpha(50),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(width: 1, color: AppColors.red),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(width: 1, color: AppColors.red),
      ),
    );
  }

  Future<void> showModalSheet(BuildContext context) async {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (modalContext) {
        return BlocProvider.value(
          value: viewModel,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 40.0),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: context.spaceHeight * 0.45,
              ),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(25),
              ),
              child: BlocBuilder<EditProfileViewModel, EditProfileState>(
                bloc: viewModel,
                builder: (context, state) {
                  return GridView.builder(
                    padding: context.withPadding(16),
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                    itemBuilder: (context, index) {
                      final avatarPath = AvatarData.avatarList[index].imagePath;
                      final isSelected = avatarPath == state.selectedAvatar;
                      return GestureDetector(
                        onTap: () {
                          viewModel.add(
                            AvatarChangedEvent(
                              AvatarData.avatarList[index].imagePath,
                            ),
                          );

                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: context.withPadding(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.yellow
                                : Colors.transparent,
                            border: Border.all(color: AppColors.yellow),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Image.asset(
                            AvatarData.avatarList[index].imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
