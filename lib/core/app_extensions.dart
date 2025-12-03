import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';





extension ThemeExtension on BuildContext{
  ThemeData get theme => Theme.of(this);
  ColorScheme get color=> Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
  double get spaceHeight => MediaQuery.sizeOf(this).height;
  double get spaceWidth => MediaQuery.sizeOf(this).width;
  AppLocalizations get locale => AppLocalizations.of(this)!;
  EdgeInsets  withPadding(double padding) => EdgeInsets.all(padding);
  EdgeInsets  withMargin(double margin) => EdgeInsets.all(margin);

}