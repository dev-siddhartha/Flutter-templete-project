import 'package:flutter/material.dart';
import 'package:flutter_template/core/constants/environment_config.dart';
import 'package:flutter_template/core/utils/app_imports.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(EnvironmentConfig.appEnvironment),
      ),
      body: Center(
        child: TextWidget('Hello, World1').onTap(() {
          getIt<NavigationService>().navigateTo(RouteNames.screen2);
        }),
      ),
    );
  }
}
