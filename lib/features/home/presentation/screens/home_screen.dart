import 'package:flutter/material.dart';
import 'package:flutter_template/core/utils/localization/localization_service.dart';
import 'package:flutter_template/core/widgets/app_bar_widget.dart';
import 'package:flutter_template/core/widgets/text_widget.dart';

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
      ),
      body: Center(
        child: TextWidget(l10(context).home),
      ),
    );
  }
}
