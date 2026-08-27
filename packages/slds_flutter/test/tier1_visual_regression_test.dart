import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slds_flutter/slds_flutter.dart';

void main() {
  testWidgets('Tier 1 light mode visual baseline', (tester) async {
    await tester.pumpWidget(const _Tier1GoldenHarness(data: null));

    await expectLater(
      find.byKey(const Key('tier1-golden-surface')),
      matchesGoldenFile('goldens/tier1_light.png'),
    );
  });
}

class _Tier1GoldenHarness extends StatelessWidget {
  const _Tier1GoldenHarness({required this.data});

  final SldsTokenSet? data;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        home: SldsTheme(
          data: data ?? SldsTokenSet.light(),
          child: Scaffold(
            body: RepaintBoundary(
              key: const Key('tier1-golden-surface'),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SldsButton(onPressed: () {}, child: const Text('Renew')),
                    const SizedBox(height: 16),
                    SldsInput(
                        controller: TextEditingController(),
                        label: 'Email address'),
                    const SizedBox(height: 16),
                    SldsCheckbox(
                      value: true,
                      onChanged: (_) {},
                      label: 'I confirm the information is correct',
                    ),
                    const SizedBox(height: 16),
                    const SldsBadge(
                      label: 'Approved',
                      type: SldsBadgeType.approved,
                    ),
                    const SizedBox(height: 16),
                    const SldsCard(child: Text('Card Title')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
