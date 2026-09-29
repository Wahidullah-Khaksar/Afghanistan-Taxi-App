import 'package:flutter/widgets.dart';

/// A language the user can pick in the app.
///
/// [nativeName] is deliberately NOT localized: each language is always
/// shown in its own script so users can find it, whatever language the app
/// is currently in.
class AppLanguage {
  const AppLanguage({required this.locale, required this.nativeName});

  final Locale locale;
  final String nativeName;
}

/// Central place for app-wide configuration.
///
/// The visible brand name is stored in the ARB files ("appName"). This class
/// holds non-visual configuration so renaming the product stays simple.
abstract final class AppConfig {
  /// Internal placeholder name, used for logs and debugging only.
  static const String internalName = 'Afghan Taxi';

  /// ISO 4217 currency code for the Afghan Afghani.
  static const String currencyCode = 'AFN';

  /// Currency symbol shown in prices.
  static const String currencySymbol = '؋';

  /// Afghanistan international phone dialing code.
  static const String phoneCountryCode = '+93';

  /// Languages supported by the app. Dari uses Flutter's Persian ("fa") locale.
  static const List<AppLanguage> languages = [
    AppLanguage(locale: Locale('en'), nativeName: 'English'),
    AppLanguage(locale: Locale('fa'), nativeName: 'دری'),
    AppLanguage(locale: Locale('ps'), nativeName: 'پښتو'),
  ];

  static const Locale defaultLocale = Locale('en');
}
