import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsDropdown. Null fields inherit from [SldsTokenSet].
class SldsDropdownStyle {
  final Color? backgroundColor;

  final Color? borderColor;

  final Color? focusBorderColor;

  final double? borderRadius;

  final EdgeInsetsGeometry? contentPadding;

  final Color? menuBackgroundColor;

  final Color? menuBorderColor;

  final TextStyle? hintStyle;

  final TextStyle? selectedItemStyle;

  final TextStyle? itemStyle;

  final TextStyle? searchStyle;

  const SldsDropdownStyle({
    this.backgroundColor,
    this.borderColor,
    this.focusBorderColor,
    this.borderRadius,
    this.contentPadding,
    this.menuBackgroundColor,
    this.menuBorderColor,
    this.hintStyle,
    this.selectedItemStyle,
    this.itemStyle,
    this.searchStyle,
  });

  SldsDropdownStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? focusBorderColor,
    double? borderRadius,
    EdgeInsetsGeometry? contentPadding,
    Color? menuBackgroundColor,
    Color? menuBorderColor,
    TextStyle? hintStyle,
    TextStyle? selectedItemStyle,
    TextStyle? itemStyle,
    TextStyle? searchStyle,
  }) {
    return SldsDropdownStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      focusBorderColor: focusBorderColor ?? this.focusBorderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
      menuBackgroundColor: menuBackgroundColor ?? this.menuBackgroundColor,
      menuBorderColor: menuBorderColor ?? this.menuBorderColor,
      hintStyle: hintStyle ?? this.hintStyle,
      selectedItemStyle: selectedItemStyle ?? this.selectedItemStyle,
      itemStyle: itemStyle ?? this.itemStyle,
      searchStyle: searchStyle ?? this.searchStyle,
    );
  }
}
