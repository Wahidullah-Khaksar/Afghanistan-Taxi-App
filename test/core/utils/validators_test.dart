import 'package:afghanistan_taxi_app/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('normalizePhone', () {
    test('accepts common Afghan number formats', () {
      const expected = '+93701234567';

      expect(Validators.normalizePhone('0701234567'), expected);
      expect(Validators.normalizePhone('701234567'), expected);
      expect(Validators.normalizePhone('+93701234567'), expected);
      expect(Validators.normalizePhone('+93 70 123 4567'), expected);
      expect(Validators.normalizePhone('0093701234567'), expected);
      expect(Validators.normalizePhone('93701234567'), expected);
      expect(Validators.normalizePhone('070-123-4567'), expected);
    });

    test('rejects invalid numbers', () {
      expect(Validators.normalizePhone(''), isNull);
      expect(Validators.normalizePhone('12345'), isNull);
      expect(Validators.normalizePhone('0601234567'), isNull);
      expect(Validators.normalizePhone('07012345678'), isNull);
      expect(Validators.normalizePhone('+92701234567'), isNull);
      expect(Validators.normalizePhone('abcdefghij'), isNull);
    });

    test('converts Persian and Arabic digits', () {
      const expected = '+93701234567';
      const persian =
          '\u06F0\u06F7\u06F0\u06F1\u06F2\u06F3\u06F4\u06F5\u06F6\u06F7';
      const arabic =
          '\u0660\u0667\u0660\u0661\u0662\u0663\u0664\u0665\u0666\u0667';

      expect(Validators.normalizePhone(persian), expected);
      expect(Validators.normalizePhone(arabic), expected);
    });
  });

  test('validatePhone returns the right error code', () {
    expect(Validators.validatePhone(null), ValidationError.required);
    expect(Validators.validatePhone('  '), ValidationError.required);
    expect(Validators.validatePhone('123'), ValidationError.invalidPhone);
    expect(Validators.validatePhone('0701234567'), isNull);
  });

  test('validateName', () {
    expect(Validators.validateName(''), ValidationError.required);
    expect(Validators.validateName(' A '), ValidationError.nameTooShort);
    expect(Validators.validateName('Ali'), isNull);
  });

  test('validatePassword', () {
    expect(Validators.validatePassword(''), ValidationError.required);
    expect(
      Validators.validatePassword('short'),
      ValidationError.passwordTooShort,
    );
    expect(Validators.validatePassword('long-enough-1'), isNull);
  });

  test('validateConfirmPassword', () {
    expect(
      Validators.validateConfirmPassword('abc12345', ''),
      ValidationError.required,
    );
    expect(
      Validators.validateConfirmPassword('abc12345', 'abc12346'),
      ValidationError.passwordsDoNotMatch,
    );
    expect(Validators.validateConfirmPassword('abc12345', 'abc12345'), isNull);
  });

  test('validateOtp accepts exactly 6 digits, also Persian digits', () {
    expect(Validators.validateOtp(''), ValidationError.required);
    expect(Validators.validateOtp('12345'), ValidationError.invalidCode);
    expect(Validators.validateOtp('1234567'), ValidationError.invalidCode);
    expect(Validators.validateOtp('12a456'), ValidationError.invalidCode);
    expect(Validators.validateOtp('123456'), isNull);
    expect(
      Validators.validateOtp('\u06F1\u06F2\u06F3\u06F4\u06F5\u06F6'),
      isNull,
    );
  });
}
