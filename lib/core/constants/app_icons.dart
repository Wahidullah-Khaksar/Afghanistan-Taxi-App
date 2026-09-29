import 'package:flutter/material.dart';

/// Every icon used in the app, in one place.
///
/// Rule for the whole project: screens never write `Icons.xxx` directly.
/// They use `AppIcons.xxx`, so all icons stay consistent (all "rounded"
/// Material icons) and one icon can be changed everywhere by editing
/// this single file.
abstract final class AppIcons {
  // Brand / vehicle
  static const IconData taxi = Icons.local_taxi_rounded;

  // Bottom navigation
  static const IconData home = Icons.home_rounded;
  static const IconData trips = Icons.receipt_long_rounded;
  static const IconData wallet = Icons.account_balance_wallet_rounded;
  static const IconData profile = Icons.person_rounded;

  // Map and location
  static const IconData location = Icons.location_on_rounded;
  static const IconData myLocation = Icons.my_location_rounded;
  static const IconData destination = Icons.flag_rounded;
  static const IconData search = Icons.search_rounded;
  static const IconData work = Icons.work_rounded;

  // Ride actions
  static const IconData call = Icons.call_rounded;
  static const IconData chat = Icons.chat_bubble_rounded;
  static const IconData share = Icons.share_rounded;
  static const IconData star = Icons.star_rounded;

  // Payment
  static const IconData cash = Icons.payments_rounded;
  static const IconData card = Icons.credit_card_rounded;

  // Settings and support
  static const IconData settings = Icons.settings_rounded;
  static const IconData language = Icons.language_rounded;
  static const IconData darkMode = Icons.dark_mode_rounded;
  static const IconData notifications = Icons.notifications_rounded;
  static const IconData help = Icons.help_outline_rounded;
  static const IconData safety = Icons.shield_rounded;

  // Forms
  static const IconData phone = Icons.phone_rounded;
  static const IconData lock = Icons.lock_rounded;
  static const IconData email = Icons.email_rounded;
  static const IconData visibility = Icons.visibility_rounded;
  static const IconData visibilityOff = Icons.visibility_off_rounded;

  // States
  static const IconData error = Icons.error_outline_rounded;
  static const IconData empty = Icons.inbox_rounded;
  static const IconData retry = Icons.refresh_rounded;

  // General
  static const IconData back = Icons.arrow_back_rounded;
  static const IconData close = Icons.close_rounded;
  static const IconData success = Icons.check_circle_rounded;
}
