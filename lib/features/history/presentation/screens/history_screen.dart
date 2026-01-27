import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/localization/localization_service.dart';
import 'package:flutter_template/core/widgets/app_bar_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: l10(context).history,
      ),
      body: Center(
        child: TextWidget(l10(context).history),
      ),
    );
  }
}
