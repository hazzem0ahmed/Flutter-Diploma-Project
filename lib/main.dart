import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/widgets/language/language_contract.dart';
import 'package:movies/presentation/widgets/language/language_vm.dart';
import 'features/login/domain/bloc/login_bloc.dart';
import 'features/login/presentation/pages/login_screen.dart';
import 'firebase_options.dart';

import 'l10n/generated/app_localizations.dart';
import 'on_boarding/on_boarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    BlocProvider<LanguageViewModel>(
      create: (context) => LanguageViewModel(),
      child:  MoviesApp(),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
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
            OnBoarding.routeName: (_) => OnBoarding(),
            loginRoute: (_) => BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(),
              child: const LoginScreen(),)
            // homeRoute: (_) => const HomeScreen(),
          },
          initialRoute: loginRoute,
        );
      },
    );
  }
}
