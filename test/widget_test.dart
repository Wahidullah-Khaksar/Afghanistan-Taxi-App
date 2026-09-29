import 'package:afghanistan_taxi_app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App starts on the splash screen with the brand name', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: AfghanTaxiApp()));
    await tester.pump();

    expect(find.text('Afghan Taxi'), findsOneWidget);

    // Let the splash timer finish so no timer is left running.
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // After the splash the app shows the first onboarding page.
    expect(find.text('Book a taxi in seconds'), findsOneWidget);
    expect(find.byType(ProviderScope), findsOneWidget);
  });
}
