import 'package:flutter_template/core/utils/app_imports.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen1State();
}

class _Screen1State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget('Title'),
      ),
      body: Center(
        child: const Text('Hello, World3')
      ),
    );
  }
}
