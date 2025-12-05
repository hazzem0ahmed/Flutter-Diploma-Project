import 'package:flutter/material.dart';
import 'package:movies/HomeScreen.dart';
import 'package:movies/onboarding_screen.dart';
import 'package:movies/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'movies',

      initialRoute: 'HomeScreen',
      routes: {
        'HomeScreen': (context) => HomeScreen(),
        'splash_screen': (context) => SplashScreen(),
        'onboarding_screen': (context) => onboarding_screen(),
      },
    );
  }
}
