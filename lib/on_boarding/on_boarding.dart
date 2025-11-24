import 'package:flutter/material.dart';
import 'package:movies/core/app_asset.dart';
import 'package:movies/core/app_colors.dart';

import '../presentation/widgets/elevated_button/elevated_button.dart';
import 'on_boarding1.dart';

class OnBoarding extends StatelessWidget {
  static const String routeName = "/onboarding";

  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppAsset.onBoardingImage,
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
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.9)
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 24,
            right: 24,
            bottom: 60,
            child: Column(
              children: [
                 Text(
                  "Find Your Next\nFavorite Movie Here",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w500),
                ),
                 SizedBox(height: 16),
                 Text(
                  "Get access to a huge library of movies \n to suit all tastes. You will surely like it.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,),
                ),
                SizedBox(height: 16),
                ElevatedButtonWidget(onPressed: (){
                  Navigator.pushReplacementNamed(context, OnBoarding1.routeName);
                },
                  text: 'Explore Now',)
              ],
            ),
          )
        ],
      ),
    );
  }
}
