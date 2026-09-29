import 'package:afghanistan_taxi_app/features/auth/data/mock_auth_repository.dart';
import 'package:afghanistan_taxi_app/features/auth/domain/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

Matcher authError(AuthErrorCode code) =>
    throwsA(isA<AuthException>().having((e) => e.code, 'code', code));

void main() {
  const phone = '+93701234567';
  const password = 'secret-pass-1';

  late MockAuthRepository repo;

  setUp(() {
    repo = MockAuthRepository(delay: Duration.zero);
  });

  test('sign up then verify code signs the user in', () async {
    await repo.signUp(fullName: 'Ali', phone: phone, password: password);
    expect(await repo.currentUser(), isNull);

    final user = await repo.verifyOtp(
      phone: phone,
      code: MockAuthRepository.mockCode,
    );

    expect(user.fullName, 'Ali');
    expect(user.phone, phone);
    expect((await repo.currentUser())?.id, user.id);
  });

  test('signing up twice with the same phone fails', () async {
    await repo.signUp(fullName: 'Ali', phone: phone, password: password);

    await expectLater(
      repo.signUp(fullName: 'Ali 2', phone: phone, password: password),
      authError(AuthErrorCode.phoneAlreadyRegistered),
    );
  });

  test('login with a wrong password fails', () async {
    await repo.signUp(fullName: 'Ali', phone: phone, password: password);

    await expectLater(
      repo.login(phone: phone, password: 'wrong'),
      authError(AuthErrorCode.invalidCredentials),
    );
  });

  test('a wrong verification code fails', () async {
    await repo.signUp(fullName: 'Ali', phone: phone, password: password);

    await expectLater(
      repo.verifyOtp(phone: phone, code: '000000'),
      authError(AuthErrorCode.invalidCode),
    );
  });

  test('password reset lets the user log in with the new password', () async {
    await repo.signUp(fullName: 'Ali', phone: phone, password: password);

    await repo.resetPassword(
      phone: phone,
      code: MockAuthRepository.mockCode,
      newPassword: 'new-pass-2',
    );

    await repo.login(phone: phone, password: 'new-pass-2');
    await expectLater(
      repo.login(phone: phone, password: password),
      authError(AuthErrorCode.invalidCredentials),
    );
  });

  test('logout clears the current user', () async {
    await repo.signUp(fullName: 'Ali', phone: phone, password: password);
    await repo.verifyOtp(phone: phone, code: MockAuthRepository.mockCode);

    await repo.logout();

    expect(await repo.currentUser(), isNull);
  });
}
