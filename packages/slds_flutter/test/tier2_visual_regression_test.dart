import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slds_flutter/slds_flutter.dart';

void main() {
  testWidgets('Tier 2 light mode visual baseline', (tester) async {
    await tester.pumpWidget(const _Tier2GoldenHarness());

    await expectLater(
      find.byKey(const Key('tier2-golden-surface')),
      matchesGoldenFile('goldens/tier2_light.png'),
    );
  });
}

class _Tier2GoldenHarness extends StatelessWidget {
  const _Tier2GoldenHarness();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        home: SldsTheme(
          data: SldsTokenSet.light(),
          child: Scaffold(
            body: RepaintBoundary(
              key: const Key('tier2-golden-surface'),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SldsTabBar(
                      selectedIndex: 0,
                      onChanged: (_) {},
                      items: const [
                        SldsTabItem(label: 'Overview', badgeCount: 2),
                        SldsTabItem(label: 'History'),
                        SldsTabItem(label: 'Files'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const SldsProgressBar(value: 60),
                    const SizedBox(height: 16),
                    const SldsStepper(totalSteps: 6, currentStep: 3),
                    const SizedBox(height: 16),
                    SldsListItem(
                      title: 'Revenue licence',
                      description: 'Renewal service',
                      leading: const Icon(Icons.work_outline),
                      badge: const SldsBadge(
                        label: 'Open',
                        type: SldsBadgeType.info,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),
                    const SldsAccordion(
                      title: 'Required documents',
                      initialExpansion: true,
                      child: Text('NIC, vehicle number and insurance.'),
                    ),
                    const SizedBox(height: 16),
                    const Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        SldsAvatar(initials: 'LK'),
                        SldsChip(label: 'Verified'),
                        SldsTag(label: 'Priority', type: SldsBadgeType.pending),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const SldsTooltip(
                      title: 'Tooltip Title',
                      description: 'Enter the description text',
                    ),
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
