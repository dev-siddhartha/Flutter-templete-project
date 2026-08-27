import 'package:flutter_template/core/constants/app_palette.dart';
import 'package:slds_flutter/slds_flutter.dart';

/// Single source of truth for building [SldsTokenSet]s with the project's
/// palette applied.
///
/// Every screen/theme entry point should build its token set through here
/// instead of calling `SldsTokenSet.light/dark/highContrast()` directly —
/// that keeps [AppPalette] the only file to edit when the project's colors
/// change, instead of updating every call site individually.
class AppTokenSet {
  AppTokenSet._();

  static SldsTokenSet light() =>
      SldsTokenSet.light(palette: AppPalette.palette);

  static SldsTokenSet dark() =>
      SldsTokenSet.dark(palette: AppPalette.palette);

  static SldsTokenSet highContrast() =>
      SldsTokenSet.highContrast(palette: AppPalette.palette);
}
