// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Afghan Taxi';

  @override
  String get splashTagline => 'Safe, fast and reliable rides';

  @override
  String get phaseOneReady => 'Phase 1 setup complete';

  @override
  String get chooseLanguage => 'Language';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingGetStarted => 'Get started';

  @override
  String get onboarding1Title => 'Book a taxi in seconds';

  @override
  String get onboarding1Body =>
      'Choose your pickup and destination, and a nearby taxi will come to you.';

  @override
  String get onboarding2Title => 'Safe and trusted rides';

  @override
  String get onboarding2Body =>
      'See your driver\'s details, share your trip with family and get help any time.';

  @override
  String get onboarding3Title => 'Pay the way you like';

  @override
  String get onboarding3Body =>
      'Pay with cash or your wallet, and see the fare before you ride.';
}
