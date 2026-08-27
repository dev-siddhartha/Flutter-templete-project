// Example widget test - see docs/testing.md "Widget tests" for the pattern this follows.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/core/widgets/app_network_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slds_flutter/slds_flutter.dart';

void main() {
  Widget wrap(Widget child) {
    // Any widget reading context.slds (AppNetworkImage does, for its
    // placeholder/error colors) needs an SldsTheme ancestor in tests too -
    // and SldsTokenSet itself needs ScreenUtil initialized (it uses .r/.w
    // internally), so this also needs a ScreenUtilInit ancestor.
    return ScreenUtilInit(
      builder: (context, _) => MaterialApp(
        home: SldsTheme(
          data: SldsTokenSet.light(),
          child: Scaffold(body: child),
        ),
      ),
    );
  }

  testWidgets('shows a loading indicator before the image resolves', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        const AppNetworkImage(
          imageUrl: 'https://example.com/avatar.png',
          width: 40,
          height: 40,
        ),
      ),
    );

    // Single pump (not pumpAndSettle): the network fetch hasn't resolved
    // yet, so the placeholder should be showing.
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
