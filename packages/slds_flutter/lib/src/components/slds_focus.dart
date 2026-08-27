import 'package:flutter/widgets.dart';

import '../tokens/slds_tokens.dart';
import 'slds_state.dart';

/// Token-bound focus decoration used across interactive components.
List<BoxShadow> sldsFocusRing(SldsTokenSet tokens) {
  return [
    BoxShadow(
      color: tokens.colors.focusRing,
      spreadRadius: tokens.dimensions.focusRingSpread,
      blurRadius: tokens.dimensions.space0,
    ),
    BoxShadow(
      color: tokens.colors.focusHalo,
      spreadRadius: tokens.dimensions.space0,
      blurRadius: tokens.dimensions.space6,
    ),
  ];
}

/// Shared outline-border color resolution for surface-style components
/// (dialog, snackbar) that draw a plain semantic border with no fill tint.
/// Returns null for the resting/default state (no border drawn).
Color? sldsSurfaceBorderColor(SldsTokenSet tokens, SldsComponentState? state) {
  final colors = tokens.colors;
  switch (state) {
    case SldsComponentState.error:
      return colors.error;
    case SldsComponentState.success:
      return colors.success;
    case SldsComponentState.focus:
    case SldsComponentState.active:
      return colors.inputBorderFocused;
    case SldsComponentState.hover:
    case SldsComponentState.empty:
    case SldsComponentState.disabled:
    case SldsComponentState.loading:
      return colors.borderDecorative;
    case _:
      return null;
  }
}
