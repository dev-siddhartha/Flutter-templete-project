import 'package:flutter_template/core/utils/app_imports.dart';

/// Enum for text style types
enum TextType {
  /// fontsize: 14, fontweight: 400
  body,

  /// fontsize: 16, fontweight: 400
  bodyLarge,

  /// fontsize: 18, fontweight: 500
  title,

  /// fontsize: 16, fontweight: 500
  subTitle,

  /// fontsize: 22, fontweight: 500
  heading,

  /// fontsize: 20, fontweight: 500
  subHeading,

  /// fontsize: 26, fontweight: 500
  display,

  /// fontsize: 24, fontweight: 500
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
    this.textType = TextType.body,
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
        return Theme.of(context).textTheme.titleMedium!.copyWith(color: color);
      case TextType.subTitle:
        return Theme.of(context).textTheme.titleSmall!.copyWith(color: color);
      case TextType.heading:
        return Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: color);
      case TextType.subHeading:
        return Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: color);
      case TextType.display:
        return Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: color);
      case TextType.displaySmall:
        return Theme.of(context).textTheme.displaySmall!.copyWith(color: color);
      case TextType.custom:
        return _customStyle(context, defaultColor);
      case TextType.body:
        return Theme.of(context).textTheme.bodyMedium!.copyWith(color: color);
      case TextType.bodyLarge:
        return Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: color, fontWeight: FontWeight.w500);
    }
  }

  /// Style generator for custom text options
  TextStyle _customStyle(BuildContext context, Color defaultColor) {
    return context.getFontStyle(
      fontSize: textOptions?.fontSize ?? 14.sp,
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
