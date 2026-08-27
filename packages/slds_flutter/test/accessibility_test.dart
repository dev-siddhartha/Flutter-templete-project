import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slds_flutter/slds_flutter.dart';

void main() {
  const samples = [
    (
      label: 'Latin script',
      strings: _SampleStrings(
        button: 'Renew revenue licence',
        inputLabel: 'Email address',
        inputHint: 'citizen@example.gov.lk',
        checkbox: 'I confirm the information is correct',
      ),
    ),
    (
      label: 'Sinhala script',
      strings: _SampleStrings(
        button: 'වාහන ආදායම් බලපත්‍රය අලුත් කරන්න',
        inputLabel: 'විද්‍යුත් තැපෑල',
        inputHint: 'පුරවැසි@example.gov.lk',
        checkbox: 'මම තොරතුරු නිවැරදි බව තහවුරු කරමි',
      ),
    ),
    (
      label: 'Tamil script',
      strings: _SampleStrings(
        button: 'வாகன வரி உரிமத்தை புதுப்பிக்கவும்',
        inputLabel: 'மின்னஞ்சல்',
        inputHint: 'குடிமகன்@example.gov.lk',
        checkbox: 'தகவல் சரியானது என்பதை நான் உறுதிப்படுத்துகிறேன்',
      ),
    ),
  ];

  for (final sample in samples) {
    testWidgets(
      'Button, Input, Checkbox meet accessibility guidelines (${sample.label})',
      (tester) async {
        final handle = tester.ensureSemantics();

        await tester.pumpWidget(
          _Harness(
            child: Column(
              children: [
                SldsButton(
                  onPressed: () {},
                  child: Text(sample.strings.button),
                ),
                const SizedBox(height: 16),
                SldsInput(
                  controller: TextEditingController(),
                  label: sample.strings.inputLabel,
                  placeholder: sample.strings.inputHint,
                  helperText: sample.strings.inputHint,
                  required: true,
                ),
                const SizedBox(height: 16),
                SldsCheckbox(
                  value: true,
                  onChanged: (_) {},
                  label: sample.strings.checkbox,
                ),
              ],
            ),
          ),
        );

        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        await expectLater(tester, meetsGuideline(textContrastGuideline));

        handle.dispose();
      },
    );
  }
}

class _Harness extends StatelessWidget {
  const _Harness({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, screenUtilChild) => MaterialApp(
        home: SldsTheme(
          data: SldsTokenSet.light(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              body: Center(
                child: Padding(padding: const EdgeInsets.all(24), child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SampleStrings {
  const _SampleStrings({
    required this.button,
    required this.inputLabel,
    required this.inputHint,
    required this.checkbox,
  });

  final String button;
  final String inputLabel;
  final String inputHint;
  final String checkbox;
}
