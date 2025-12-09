import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/Register/register_screen.dart';
import 'package:movies/presentation/screens/details_screen/details_screen.dart';
import 'package:movies/presentation/screens/home_screen.dart';
import 'package:movies/presentation/screens/splash_screen.dart';
import 'package:movies/presentation/widgets/language/language_contract.dart';
import 'package:movies/presentation/widgets/language/language_vm.dart';
import 'di/modules/service_locator.dart';
import 'features/login/presentation/pages/login_screen.dart';
import 'firebase_options.dart';
import 'l10n/generated/app_localizations.dart';
import 'on_boarding/on_boarding_final.dart';
const String webClientId = 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependenciesGetIt();

  runApp(
    BlocProvider<LanguageViewModel>(
      create: (context) => LanguageViewModel(),
      child: const MoviesApp(),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageViewModel, LocalizationState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: state.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,

          routes: {
            OnBoardingFinal.routeName: (_) => OnBoardingFinal(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            RegisterScreen.routeName: (context) => const RegisterScreen(),
            SplashScreen.routeName: (context) => const SplashScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            DetailsScreen.routeName: (context) => const DetailsScreen(),
          },
          initialRoute: OnBoardingFinal.routeName,
        );
      },
    );
  }
}
