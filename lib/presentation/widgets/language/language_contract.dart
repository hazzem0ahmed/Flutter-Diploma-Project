import 'package:flutter/material.dart';

class LocalizationState{
  final Locale locale;

  LocalizationState({this.locale = const Locale('en')});
}

sealed class LocalizationAction{
  Locale locale;

  LocalizationAction(this.locale);
}

class ChangeLanguageEvent extends LocalizationAction{
  ChangeLanguageEvent(super.locale);

}