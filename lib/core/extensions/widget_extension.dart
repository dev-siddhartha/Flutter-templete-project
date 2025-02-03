import 'package:flutter_template/core/utils/app_imports.dart';

extension WidgetExtension on Widget {
  //for tapping
  GestureDetector onTap(
    GestureTapCallback callback,
  ) =>
      GestureDetector(
        onTap: callback,
        child: this,
      );

  //for padding
  Padding padding({
    EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  }) =>
      Padding(
        padding: padding,
        child: this,
      );
}
