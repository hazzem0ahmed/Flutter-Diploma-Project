import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/on_boarding/on_boarding3.dart';
import 'package:movies/presentation/widgets/language/language_contract.dart';
import 'package:movies/presentation/widgets/language/language_vm.dart';
import 'l10n/generated/app_localizations.dart';
import 'on_boarding/on_boarding.dart';
import 'on_boarding/on_boarding1.dart';
import 'on_boarding/on_boarding2.dart';
import 'on_boarding/on_boarding4.dart';
import 'on_boarding/on_boarding5.dart';

void main() {
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
  OnBoarding.routeName :( _)=>OnBoarding(),
  OnBoarding1.routeName :( _)=>OnBoarding1(),
  OnBoarding2.routeName :( _)=>OnBoarding2(),
  OnBoarding3.routeName :( _)=>OnBoarding3(),
  OnBoarding4.routeName :( _)=>OnBoarding4(),
  OnBoarding5.routeName :( _)=>OnBoarding5(),
},
 initialRoute: OnBoarding.routeName,


        );
      },
    );
  }
}