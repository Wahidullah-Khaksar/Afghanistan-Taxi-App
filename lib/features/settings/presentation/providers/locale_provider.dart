import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/app_config.dart';

/// Holds the language currently selected by the user.
///
/// Persistence (remembering the choice after restart) is added in a later
/// phase together with the Settings screen.
class LocaleController extends Notifier<Locale> {
  @override
  Locale build() => AppConfig.defaultLocale;

  void setLocale(Locale locale) {
    state = locale;
  }
}

final localeProvider = NotifierProvider<LocaleController, Locale>(
  LocaleController.new,
);
