import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slds_flutter/slds_flutter.dart';

void main() {
  testWidgets('Tier 1 components expose the nine required states', (
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
                          SldsButton(
                            state: state,
                            onPressed: () {},
                            child: Text('button-${state.name}'),
                          ),
                          SldsInput(
                            controller: TextEditingController(),
                            label: 'input-${state.name}',
                            state: state,
                            errorText: 'Enter a valid email address',
                          ),
                          SldsTextArea(
                            controller: TextEditingController(),
                            label: 'textarea-${state.name}',
                            state: state,
                          ),
                          SldsCheckbox(
                            value: true,
                            onChanged: (_) {},
                            label: 'checkbox-${state.name}',
                            state: state,
                          ),
                          SldsRadio<String>(
                            value: state.name,
                            groupValue: state.name,
                            onChanged: (_) {},
                            label: 'radio-${state.name}',
                            state: state,
                          ),
                          SldsToggle(
                            value: true,
                            onChanged: (_) {},
                            semanticLabel: 'toggle-${state.name}',
                            state: state,
                          ),
                          SldsDropdown<String>(
                            label: 'dropdown-${state.name}',
                            value: 'colombo',
                            onChanged: (_) {},
                            state: state,
                            items: const [
                              SldsDropdownItem(
                                value: 'colombo',
                                label: 'Colombo',
                              ),
                            ],
                          ),
                          SldsBadge(
                            label: 'badge-${state.name}',
                            type: SldsBadgeType.approved,
                            state: state,
                          ),
                          SldsCard(
                            state: state,
                            child: Text('card-${state.name}'),
                          ),
                          SldsDialog(
                            title: 'dialog-${state.name}',
                            message: 'Confirm before continuing.',
                            state: state,
                          ),
                          SldsSnackbar(
                            title: 'snackbar-${state.name}',
                            description: 'Your progress has been saved.',
                            state: state,
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
      expect(find.text('button-${state.name}'), findsOneWidget);
      expect(find.text('input-${state.name}'), findsOneWidget);
      expect(find.text('textarea-${state.name}'), findsOneWidget);
      expect(find.text('checkbox-${state.name}'), findsOneWidget);
      expect(find.text('radio-${state.name}'), findsOneWidget);
      expect(find.text('dropdown-${state.name}'), findsOneWidget);
      expect(find.text('badge-${state.name}'), findsOneWidget);
      expect(find.text('card-${state.name}'), findsOneWidget);
      expect(find.text('dialog-${state.name}'), findsOneWidget);
      expect(find.text('snackbar-${state.name}'), findsOneWidget);
    }
  });
}
