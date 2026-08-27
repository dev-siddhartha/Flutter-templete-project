import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slds_flutter/slds_flutter.dart';

void main() {
  testWidgets('Tier 2 components expose the nine required states', (
    tester,
  ) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          home: SldsTheme(
            data: SldsTokenSet.light(),
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    for (final state in SldsComponentState.values)
                      Column(
                        children: [
                          SldsTabBar(
                            selectedIndex: 0,
                            onChanged: (_) {},
                            state: state,
                            items: [
                              SldsTabItem(label: 'tab-${state.name}'),
                              const SldsTabItem(label: 'Services'),
                            ],
                          ),
                          SldsAccordion(
                            title: 'accordion-${state.name}',
                            initialExpansion: true,
                            state: state,
                            child: Text('accordion-body-${state.name}'),
                          ),
                          SldsListItem(
                            title: 'list-${state.name}',
                            description: 'list-body-${state.name}',
                            leading: const Icon(Icons.work_outline),
                            trailing: const Icon(Icons.chevron_right),
                            badge: const SldsBadge(
                              label: 'Open',
                              type: SldsBadgeType.info,
                            ),
                            onTap: () {},
                            state: state,
                          ),
                          SldsPagination(
                            currentPage: 2,
                            totalPages: 5,
                            onPageChanged: (_) {},
                            state: state,
                          ),
                          SldsProgressBar(
                            value: 40,
                            state: state,
                            semanticLabel: 'progress-${state.name}',
                          ),
                          SldsStepper(
                            totalSteps: 6,
                            currentStep: 3,
                            state: state,
                            semanticLabel: 'stepper-${state.name}',
                          ),
                          SldsAvatar(
                            initials: 'LK',
                            state: state,
                            semanticLabel: 'avatar-${state.name}',
                          ),
                          SldsChip(
                            label: 'chip-${state.name}',
                            onDeleted: () {},
                            state: state,
                          ),
                          SldsTag(
                            label: 'tag-${state.name}',
                            state: state,
                          ),
                          SldsTooltip(
                            title: 'tooltip-${state.name}',
                            description: 'tooltip-body-${state.name}',
                            state: state,
                          ),
                          SizedBox(
                            height: 400,
                            child: SldsNavigationDrawer(
                              title: 'drawer-${state.name}',
                              state: state,
                              items: [
                                SldsNavigationDrawerItem(
                                  label: 'drawer-item-${state.name}',
                                  description: 'drawer-body-${state.name}',
                                  icon: Icons.home_outlined,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    for (final state in SldsComponentState.values) {
      expect(find.text('tab-${state.name}'), findsOneWidget);
      expect(find.text('accordion-${state.name}'), findsOneWidget);
      expect(find.text('accordion-body-${state.name}'), findsOneWidget);
      expect(find.text('list-${state.name}'), findsOneWidget);
      expect(find.text('chip-${state.name}'), findsOneWidget);
      expect(find.text('tag-${state.name}'), findsOneWidget);
      expect(find.text('tooltip-${state.name}'), findsOneWidget);
      expect(find.text('drawer-${state.name}'), findsOneWidget);
      expect(find.text('drawer-item-${state.name}'), findsOneWidget);
    }
  });
}
