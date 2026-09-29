import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/mock_auth_repository.dart';
import '../../domain/auth_repository.dart';

/// The authentication backend used by the app.
///
/// To connect a real server later, return the real implementation here.
/// No screen needs to change.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return MockAuthRepository();
});
