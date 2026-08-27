import 'package:flutter/material.dart';
import 'package:flutter_template/core/utils/localization/localization_service.dart';
import 'package:flutter_template/core/widgets/app_bar_widget.dart';
import 'package:slds_flutter/slds_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: l10(context).home,
        showBackButton: false,
      ),
      body: Center(
        child: SldsText(l10(context).home),
      ),
    );
  }
}
