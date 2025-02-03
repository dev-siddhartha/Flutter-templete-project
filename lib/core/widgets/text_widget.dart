import 'package:flutter_template/core/utils/app_imports.dart';

/// Enum for text style types
enum TextType {
  normal,
  title,
  subTitle,
  heading,
  subHeading,
  display,
  displaySmall,
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
    final defaultColor =
        color ?? Theme.of(context).textTheme.bodyMedium!.color!;

    switch (textType) {
      case TextType.title:
        return Theme.of(context).textTheme.titleMedium!;
      case TextType.subTitle:
        return Theme.of(context).textTheme.titleSmall!;
      case TextType.heading:
        return Theme.of(context).textTheme.headlineMedium!;
      case TextType.subHeading:
        return Theme.of(context).textTheme.headlineSmall!;
      case TextType.display:
        return Theme.of(context).textTheme.displayMedium!;
      case TextType.displaySmall:
        return Theme.of(context).textTheme.displaySmall!;
      case TextType.custom:
        return _customStyle(context, defaultColor);
      case TextType.normal:
        return Theme.of(context).textTheme.bodyMedium!;
    }
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
