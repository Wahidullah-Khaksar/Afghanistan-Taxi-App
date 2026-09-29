/// Reasons why a form field can be invalid.
///
/// Validators never return user-facing text. Screens turn each code into a
/// localized message.
enum ValidationError {
  required,
  invalidPhone,
  nameTooShort,
  passwordTooShort,
  passwordsDoNotMatch,
  invalidCode,
}

/// Input checks for authentication forms.
abstract final class Validators {
  static const int minPasswordLength = 8;
  static const int otpLength = 6;

  /// Converts Persian (۰-۹) and Arabic-Indic (٠-٩) digits to Latin (0-9).
  /// Many users type with a Persian keyboard.
  static String toLatinDigits(String input) {
    final buffer = StringBuffer();
    for (final rune in input.runes) {
      if (rune >= 0x06F0 && rune <= 0x06F9) {
        buffer.write(rune - 0x06F0);
      } else if (rune >= 0x0660 && rune <= 0x0669) {
        buffer.write(rune - 0x0660);
      } else {
        buffer.writeCharCode(rune);
      }
    }
    return buffer.toString();
  }

  /// Converts what the user typed into the international format
  /// "+93701234567", or returns null if it is not a valid Afghan mobile
  /// number (9 digits after the country code, starting with 7).
  static String? normalizePhone(String input) {
    var digits = toLatinDigits(input).replaceAll(RegExp(r'[\s\-().]'), '');

    if (digits.startsWith('+93')) {
      digits = digits.substring(3);
    } else if (digits.startsWith('0093')) {
      digits = digits.substring(4);
    } else if (digits.startsWith('93') && digits.length == 11) {
      digits = digits.substring(2);
    } else if (digits.startsWith('0')) {
      digits = digits.substring(1);
    }

    if (!RegExp(r'^7\d{8}$').hasMatch(digits)) return null;
    return '+93$digits';
  }

  static ValidationError? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return ValidationError.required;
    if (normalizePhone(value) == null) return ValidationError.invalidPhone;
    return null;
  }

  static ValidationError? validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return ValidationError.required;
    if (name.length < 2) return ValidationError.nameTooShort;
    return null;
  }

  static ValidationError? validatePassword(String? value) {
    if (value == null || value.isEmpty) return ValidationError.required;
    if (value.length < minPasswordLength) {
      return ValidationError.passwordTooShort;
    }
    return null;
  }

  static ValidationError? validateConfirmPassword(
    String? password,
    String? confirmation,
  ) {
    if (confirmation == null || confirmation.isEmpty) {
      return ValidationError.required;
    }
    if (password != confirmation) return ValidationError.passwordsDoNotMatch;
    return null;
  }

  static ValidationError? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) return ValidationError.required;
    final code = toLatinDigits(value.trim());
    if (!RegExp('^\\d{$otpLength}\$').hasMatch(code)) {
      return ValidationError.invalidCode;
    }
    return null;
  }
}
