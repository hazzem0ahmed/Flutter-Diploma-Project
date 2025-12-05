import 'package:flutter/material.dart';
import 'package:movies/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, onboarding_screen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(child: Image.asset('assets/images/splash_screen_1.png')),
          Positioned(
            bottom: 32,
            child: Image.asset('assets/icons/Mask_group.png'),
          ),
          Positioned(
            bottom: 16,
            child: Image.asset('assets/icons/supervisor.png'),
          ),
        ],
      ),
    );
  }
}
