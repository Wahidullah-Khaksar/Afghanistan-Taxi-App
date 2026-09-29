import '../../../shared/models/app_user.dart';

/// Reasons why an authentication action can fail.
///
/// Screens turn each code into a localized message. The repository never
/// returns user-facing text.
enum AuthErrorCode {
  invalidCredentials,
  phoneAlreadyRegistered,
  invalidCode,
  userNotFound,
  network,
}

class AuthException implements Exception {
  const AuthException(this.code);

  final AuthErrorCode code;

  @override
  String toString() => 'AuthException(${code.name})';
}

/// Everything the app can do with a user account.
///
/// Today it is implemented by `MockAuthRepository`. Later a real backend
/// implementation replaces it in one place and no screen changes.
///
/// Sign up and login both end with a phone verification code: after
/// [signUp] or [login] succeeds, the user enters the code and the screen
/// calls [verifyOtp].
abstract interface class AuthRepository {
  /// The signed-in user, or null if nobody is signed in.
  Future<AppUser?> currentUser();

  /// Creates an account and sends a verification code to [phone].
  Future<void> signUp({
    required String fullName,
    required String phone,
    required String password,
  });

  /// Checks the phone and password and sends a verification code.
  Future<void> login({required String phone, required String password});

  /// Checks the verification code and signs the user in.
  Future<AppUser> verifyOtp({required String phone, required String code});

  /// Sends a password reset code to [phone].
  Future<void> requestPasswordReset(String phone);

  /// Sets a new password using the reset code.
  Future<void> resetPassword({
    required String phone,
    required String code,
    required String newPassword,
  });

  Future<void> logout();
}
