import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/Register/register_screen.dart';
import 'package:movies/presentation/screens/details_screen/details_screen.dart';
import 'package:movies/presentation/screens/home_screen.dart';
import 'package:movies/presentation/screens/splash_screen.dart';
import 'package:movies/presentation/screens/tabs/profile_tab/profile_tabs_content/history_tab/History_Cubit.dart';
import 'package:movies/presentation/widgets/language/language_contract.dart';
import 'package:movies/presentation/widgets/language/language_vm.dart';
import 'di/modules/service_locator.dart';
import 'features/login/presentation/pages/login_screen.dart';
import 'firebase_options.dart';
import 'l10n/generated/app_localizations.dart';
import 'on_boarding/on_boarding.dart';
import 'on_boarding/on_boarding_final.dart';
const String webClientId = 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependenciesGetIt();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LanguageViewModel>(
          create: (context) => LanguageViewModel(),
        ),
        BlocProvider<HistoryCubit>(
          create: (context) => HistoryCubit(),
        ),
      ],
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
            OnBoardingScreen.routeName: (_) => const OnBoardingScreen(),
            OnBoardingFinal.routeName: (_) => OnBoardingFinal(),
            LoginScreen.routeName: (_) => const LoginScreen(),
            RegisterScreen.routeName: (_) => const RegisterScreen(),
            SplashScreen.routeName: (_) => const SplashScreen(),
            HomeScreen.routeName: (_) => HomeScreen(),
            DetailsScreen.routeName: (_) => const DetailsScreen(),
          },
          initialRoute: HomeScreen.routeName,

        );
      },
    );
  }
}
