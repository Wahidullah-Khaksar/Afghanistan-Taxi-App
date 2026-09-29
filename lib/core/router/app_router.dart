import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/dev/presentation/widgets_demo_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

/// All route paths in one place, so no screen uses hard-coded strings.
abstract final class AppRoutes {
  static const String splash = '/';

  /// TEMPORARY developer route. Removed before release.
  static const String widgetsDemo = '/widgets-demo';
}

/// The app router, exposed through Riverpod so guards (login, onboarding,
/// active ride) can read providers in later phases.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.widgetsDemo,
        name: 'widgetsDemo',
        builder: (context, state) => const WidgetsDemoScreen(),
      ),
    ],
  );
});
