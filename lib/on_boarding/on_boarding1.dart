import 'on_boarding2.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/app_asset.dart';
import 'package:movies/core/app_colors.dart';
import '../presentation/widgets/elevated_button/elevated_button.dart';


class OnBoarding1 extends StatelessWidget {
  static const String routeName = "/onboarding1";
  const OnBoarding1({super.key});

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
                child: Image.asset(AppAsset.onBoarding1Image,
                  fit: BoxFit.cover,
                ),
              )
             , Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.2),
                      Color(0xFF084250),
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
                children: [

                  Text(
                    "Discover Movies",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Explore a vast collection of movies in all\n qualities and genres. Find your next \n favorite film with ease.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.white,
                    ),
                  ),

                  SizedBox(height: 20),
                  ElevatedButtonWidget(onPressed: (){
                    Navigator.pushReplacementNamed(context, OnBoarding2.routeName);
                  },
                    text: 'Next',),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
