import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/auth/data/datasource/contract/auth_local_datasource.dart';
import 'package:movies/core/app_asset.dart';
import 'package:movies/di/modules/service_locator.dart';
import 'package:movies/firebase_options.dart';
import 'package:movies/presentation/screens/HomeScreen.dart';
import '../../on_boarding/on_boarding_final.dart';

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
    _initializeAndNavigate();
  }

  Future<void> _initializeAndNavigate() async {
    // Perform all the initializations here
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    configureDependenciesGetIt();

    final authLocal = getIt<AuthLocalDatasource>();
    final String? savedToken = await authLocal.getSavedToken();

    // Ensure the widget is still mounted before navigating
    if (!mounted) return;

    if (savedToken != null) {
      // If token exists, go to home
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      // Otherwise, go to onboarding
      Navigator.pushReplacementNamed(context, OnBoardingFinal.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    // The UI remains the same, showing the splash screen while initializing
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(child: Image.asset(AppAsset.appLogo)),
          Positioned(
            bottom: 32,
            child: Image.asset(AppAsset.routeLogo),
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
