// Example integration test - see docs/testing.md "Integration tests" for the pattern
// this follows. Needs a connected device/emulator plus a real .env.dev and the dev
// Firebase config files in place (see .env.example / *.example under android & ios).
//
// Run with: flutter test integration_test/app_test.dart -d <device-id>
import 'package:flutter_template/entry_point.dart';
import 'package:flutter_template/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('app boots to the login screen when logged out', (
    tester,
  ) async {
    // Runs the same bootstrap as lib/main_dev.dart (DI, Hive, network,
    // Firebase) - integration tests run on a real device/emulator, so
    // real platform channels are available, unlike plain `flutter test`.
    await EntryPoint().initializeApp(envType: EnvType.dev);
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
