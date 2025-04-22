import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/localization/localization_service.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen1State();
}

class _Screen1State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget('Title'),
      ),
      body: Center(
        child:  TextWidget(l10.account).onTap(
          () => getIt<NavigationService>().navigateTo(RouteNames.screen3),
        ),
      ),
    );
  }
}
