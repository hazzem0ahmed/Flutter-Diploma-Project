import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/Register/register_screen.dart';
import 'package:movies/presentation/widgets/language/language_contract.dart';
import 'package:movies/presentation/widgets/language/language_vm.dart';
import 'auth/data/datasource/contract/auth_local_datasource.dart';
import 'di/service_locator.dart';
import 'firebase_options.dart';
import 'l10n/generated/app_localizations.dart';
import 'on_boarding/on_boarding.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  configureDependenciesGetIt();

  final authLocal = getIt<AuthLocalDatasource>();
  final String? savedToken = await authLocal.getSavedToken();

  runApp(
    BlocProvider<LanguageViewModel>(
      create: (context) => LanguageViewModel(),
      child: MoviesApp(token: savedToken),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key, this.token});
  final String? token;

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
            RegisterScreen.routeName: (context) => RegisterScreen(),
          },

          // لو في Token → يدخل على OnBoarding أو هوم
          // لو مفيش Token → يفتح Register
          initialRoute:
          token == null || token!.isEmpty
              ? RegisterScreen.routeName
              : OnBoarding.routeName,
        );
      },
    );
  }
}
