import 'package:flutter/material.dart';
import 'package:movies/core/app_asset.dart';
import 'package:movies/on_boarding/on_boarding.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnBoardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(child: Image.asset(AppAsset.appLogo)),
          Positioned(bottom: 32, child: Image.asset(AppAsset.routeLogo)),
          Positioned(bottom: 16, child: Image.asset(AppAsset.supervisedImage)),
        ],
      ),
    );
  }
}
