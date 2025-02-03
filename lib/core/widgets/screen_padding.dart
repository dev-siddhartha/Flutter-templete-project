import 'package:flutter_template/core/utils/app_imports.dart';

class ScreenPadding extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Widget child;
  const ScreenPadding({super.key, this.padding, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
        child: child,
      ),
    );
  }
}
