import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/app_extensions.dart';
import '../../../core/app_asset.dart';
import '../../../core/app_colors.dart';
import '../../../firebase/google_auth.dart';


class GoogleButtonDesign extends StatefulWidget {
  const GoogleButtonDesign({super.key});

  @override
  State<GoogleButtonDesign> createState() => _GoogleButtonDesignState();
}

class _GoogleButtonDesignState extends State<GoogleButtonDesign> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.black,
      ),
      onPressed: () async {
        try {
          final user = await FirebaseAuthServices().googleSignIn();

          if (user != null) {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }
        } on FirebaseAuthException catch (e) {
          Text(e.message!);
        } catch (error) {
          debugPrint(error.toString());

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAsset.googleIcon,
            width: context.spaceWidth * 0.1,
            height: context.spaceHeight * 0.05,
          ),
          Text(context.locale.logInWithGoogle),
        ],
      ),
    );
  }
}
