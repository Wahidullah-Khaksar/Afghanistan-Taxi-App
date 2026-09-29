import 'package:flutter/material.dart';

/// All brand colors of the app, in one place.
///
/// Rule for the whole project: screens never write `Color(0xFF...)`
/// directly. They read colors from the theme (or from this file), so the
/// whole look can be changed here.
abstract final class AppColors {
  // ---------------------------------------------------------------------
  // Brand colors (same in light and dark mode)
  // Based on the turquoise/sky-blue Kabul taxi.
  // ---------------------------------------------------------------------

  /// Bright turquoise: highlights, icons, map accents.
  static const Color primary = Color(0xFF0FB5C9);

  /// Dark turquoise: main buttons in light mode (white text is readable).
  static const Color primaryDark = Color(0xFF087F91);

  /// Light "car blue": taxi illustrations and taxi cards.
  static const Color carBlue = Color(0xFF5BC2E7);

  /// Secondary blue: links and secondary actions.
  static const Color secondaryBlue = Color(0xFF1565C0);

  /// Very light cyan tint: soft backgrounds in light mode.
  static const Color lightCyan = Color(0xFFE8FAFC);

  // ---------------------------------------------------------------------
  // Light theme
  // ---------------------------------------------------------------------
  static const Color lightBackground = Color(0xFFF7FBFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF102A43);
  static const Color lightTextSecondary = Color(0xFF667085);
  static const Color lightBorder = Color(0xFFDCE7EB);

  // ---------------------------------------------------------------------
  // Dark theme (designed separately, not just inverted colors)
  // ---------------------------------------------------------------------

  /// In dark mode the turquoise is a little brighter so it stays visible.
  static const Color darkPrimary = Color(0xFF2CCFE0);
  static const Color darkBackground = Color(0xFF0B1720);
  static const Color darkSurface = Color(0xFF13232E);
  static const Color darkSurfaceTint = Color(0xFF123640);
  static const Color darkTextPrimary = Color(0xFFEAF3F6);
  static const Color darkTextSecondary = Color(0xFF9BB0BB);
  static const Color darkBorder = Color(0xFF24404F);
  static const Color darkSecondaryBlue = Color(0xFF4C8DF6);

  // ---------------------------------------------------------------------
  // Status colors
  // Green is used ONLY for success, never as a brand color.
  // ---------------------------------------------------------------------
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);

  static const Color darkSuccess = Color(0xFF22C55E);
  static const Color darkWarning = Color(0xFFFBBF24);
  static const Color darkError = Color(0xFFF87171);
}
