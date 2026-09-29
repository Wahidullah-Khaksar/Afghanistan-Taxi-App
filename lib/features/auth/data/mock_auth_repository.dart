import '../../../shared/models/app_user.dart';
import '../domain/auth_repository.dart';

/// Fake authentication used while there is no backend.
///
/// - Accounts live only in memory and disappear when the app restarts.
/// - The verification code is always [mockCode]. No SMS is sent.
/// - Passwords are kept in memory here ONLY because this is a mock.
///   A real implementation never stores a password on the phone.
class MockAuthRepository implements AuthRepository {
  MockAuthRepository({this.delay = const Duration(milliseconds: 700)});

  /// The verification code accepted by this mock.
  static const String mockCode = '123456';

  /// Simulated network time. Tests pass [Duration.zero].
  final Duration delay;

  final Map<String, _MockAccount> _accounts = {};
  AppUser? _current;
  int _nextId = 1;

  Future<void> _wait() => Future<void>.delayed(delay);

  @override
  Future<AppUser?> currentUser() async => _current;

  @override
  Future<void> signUp({
    required String fullName,
    required String phone,
    required String password,
  }) async {
    await _wait();
    if (_accounts.containsKey(phone)) {
      throw const AuthException(AuthErrorCode.phoneAlreadyRegistered);
    }
    final user = AppUser(
      id: 'user-${_nextId++}',
      fullName: fullName,
      phone: phone,
    );
    _accounts[phone] = _MockAccount(user: user, password: password);
  }

  @override
  Future<void> login({required String phone, required String password}) async {
    await _wait();
    final account = _accounts[phone];
    if (account == null || account.password != password) {
      throw const AuthException(AuthErrorCode.invalidCredentials);
    }
  }

  @override
  Future<AppUser> verifyOtp({
    required String phone,
    required String code,
  }) async {
    await _wait();
    if (code != mockCode) {
      throw const AuthException(AuthErrorCode.invalidCode);
    }
    final account = _accounts[phone];
    if (account == null) {
      throw const AuthException(AuthErrorCode.userNotFound);
    }
    _current = account.user;
    return account.user;
  }

  @override
  Future<void> requestPasswordReset(String phone) async {
    await _wait();
    if (!_accounts.containsKey(phone)) {
      throw const AuthException(AuthErrorCode.userNotFound);
    }
  }

  @override
  Future<void> resetPassword({
    required String phone,
    required String code,
    required String newPassword,
  }) async {
    await _wait();
    if (code != mockCode) {
      throw const AuthException(AuthErrorCode.invalidCode);
    }
    final account = _accounts[phone];
    if (account == null) {
      throw const AuthException(AuthErrorCode.userNotFound);
    }
    account.password = newPassword;
  }

  @override
  Future<void> logout() async {
    _current = null;
  }
}

class _MockAccount {
  _MockAccount({required this.user, required this.password});

  final AppUser user;
  String password;
}
