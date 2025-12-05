import 'package:flutter/material.dart';
import 'package:movies/core/app_asset.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/on_boarding/on_boarding1.dart';
import '../features/login/presentation/pages/login_screen.dart';
import '../presentation/widgets/elevated_button/elevated_button.dart';
import '../presentation/widgets/elevated_button/outlined_button.dart';


class OnBoarding2 extends StatelessWidget {
  static const String routeName = "/onboarding2";
  const OnBoarding2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height:  MediaQuery.of(context).size.height * 0.85,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    AppAsset.onBoarding2Image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.2),
                          Color(0xFF85210E),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Explore All Genres",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Discover movies from every genre, in all\n available qualities. Find something new\n and exciting to watch every day.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButtonWidget(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    },
                    text: 'Next',
                  ),
                  const SizedBox(height: 16),
                  OutlinedButtonWidget(text: "Back", onPressed: (){
                    Navigator.pushReplacementNamed(context, OnBoarding1.routeName);
                  })

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
