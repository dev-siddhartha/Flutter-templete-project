import 'package:flutter/widgets.dart';

import '../tokens/slds_tokens.dart';

/// Makes SLDS tokens available to the widget subtree.
class SldsTheme extends InheritedWidget {
  /// Creates an SLDS theme.
  const SldsTheme({super.key, required this.data, required super.child});

  /// Active token set.
  final SldsTokenSet data;

  /// Reads the nearest token set, falling back to light tokens.
  static SldsTokenSet of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<SldsTheme>();
    return theme?.data ?? SldsTokenSet.light();
  }

  @override
  bool updateShouldNotify(SldsTheme oldWidget) => data != oldWidget.data;
}

/// Convenience extension for token access.
extension SldsThemeX on BuildContext {
  /// Active SLDS tokens.
  SldsTokenSet get slds => SldsTheme.of(this);
}
