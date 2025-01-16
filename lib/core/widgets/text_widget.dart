import 'package:neo_flutter/core/utils/app_imports.dart';

/// Enum for text style types
enum TextType {
  normal,
  title,
  subTitle,
  heading,
  subHeading,
  display,
  custom,
}

/// Options for custom text styling
class TextOptions {
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? height;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final String? fontFamily;

  const TextOptions({
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.height,
    this.letterSpacing,
    this.decoration,
    this.fontFamily,
  });
}

/// A reusable custom Text widget with predefined or custom styles
class TextWidget extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextType textType;
  final TextScaler? textScaler;
  final TextOptions? textOptions;
  final Color? color;

  const TextWidget(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.textType = TextType.normal,
    this.textScaler,
    this.color,
    this.textOptions,
  }) : assert(
          textType != TextType.custom || textOptions != null,
          'TextType.custom requires textOptions to be provided.',
        );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getTextStyle(context),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textScaler: textScaler,
    );
  }

  /// Returns the appropriate text style based on the text type or custom options
  TextStyle _getTextStyle(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final defaultColor = color ?? Theme.of(context).primaryColor;

    switch (textType) {
      case TextType.title:
        return _baseStyle(
          context,
          fontSize: isPortrait ? 16.sp : 16.5.sp,
          fontWeight: FontWeight.w500,
          color: defaultColor,
        );
      case TextType.subTitle:
        return _baseStyle(
          context,
          fontSize: isPortrait ? 14.sp : 14.5.sp,
          fontWeight: FontWeight.w500,
          color: defaultColor,
        );
      case TextType.heading:
        return _baseStyle(
          context,
          fontSize: isPortrait ? 20.sp : 20.5.sp,
          fontWeight: FontWeight.w500,
          color: defaultColor,
        );
      case TextType.subHeading:
        return _baseStyle(
          context,
          fontSize: isPortrait ? 18.sp : 18.5.sp,
          fontWeight: FontWeight.w500,
          color: defaultColor,
        );
      case TextType.display:
        return _baseStyle(
          context,
          fontSize: isPortrait ? 22.sp : 22.5.sp,
          fontWeight: FontWeight.w700,
          color: defaultColor,
        );
      case TextType.custom:
        return _customStyle(context, defaultColor);
      case TextType.normal:
        return _baseStyle(
          context,
          fontSize: isPortrait ? 14.sp : 14.5.sp,
          fontWeight: FontWeight.w400,
          color: defaultColor,
        );
    }
  }

  /// Base style generator for predefined text types
  TextStyle _baseStyle(BuildContext context,
      {required double fontSize,
      required FontWeight fontWeight,
      required Color color}) {
    return context.getFontStyle(
        fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  /// Style generator for custom text options
  TextStyle _customStyle(BuildContext context, Color defaultColor) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return context.getFontStyle(
      fontSize: textOptions?.fontSize ?? (isPortrait ? 14 : 14.5),
      fontWeight: textOptions?.fontWeight ?? FontWeight.w400,
      fontStyle: textOptions?.fontStyle,
      height: textOptions?.height,
      letterSpacing: textOptions?.letterSpacing,
      decoration: textOptions?.decoration,
      fontFamily: textOptions?.fontFamily,
      color: color ?? defaultColor,
    );
  }
}
