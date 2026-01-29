import 'dart:async';

import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/connection_check/connection_check_io.dart'
    if (dart.library.html) 'package:flutter_template/core/utils/connection_check/connection_check_web.dart'
    as connection_check;

enum ButtonSize { small, medium, large }

class InputButton extends StatefulWidget {
  final void Function()? onPressed;
  final String buttonText;
  final Color? color;
  final Color? borderColor;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final ButtonSize? buttonSize;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? disableColor;
  final Color? disableBorderColor;
  final bool isOutlined;
  final bool isLoading;

  // for icon after text
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final int? iconAndTextGap;

  /// if this is false, on tap will not work
  final bool enabled;

  final String? disableMessage;

  const InputButton({
    super.key,
    required this.onPressed,
    this.fontColor,
    required this.buttonText,
    this.color,
    this.borderColor,
    this.fontWeight,
    this.fontSize,
    this.buttonSize = ButtonSize.medium,
    this.height,
    this.width,
    this.padding,
    this.borderRadius,
    this.prefixIcon,
    this.iconAndTextGap,
    this.suffixIcon,
    this.disableColor,
    this.disableBorderColor,

    /// works only if enabled
    this.isOutlined = false,

    /// shows loading instead of text
    this.isLoading = false,
    this.enabled = true,
    this.disableMessage,
  });

  @override
  State<InputButton> createState() => _InputButtonState();
}

class _InputButtonState extends State<InputButton>
    with TickerProviderStateMixin {
  Timer? _debounce;
  final ValueNotifier<bool> _isEnabled = ValueNotifier<bool>(true);

  Future<bool> hasInternetConnection() async {
    return connection_check.hasInternetConnection();
  }

  @override
  void initState() {
    super.initState();
    _isEnabled.value = widget.enabled;
  }

  @override
  void didUpdateWidget(covariant InputButton oldWidget) {
    _isEnabled.value = widget.enabled;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (_debounce != null) {
      _debounce!.cancel();
    }
    super.dispose();
  }

  double height() {
    switch (widget.buttonSize) {
      case ButtonSize.small:
        return 40.h;
      case ButtonSize.medium:
        return 48.h;
      case ButtonSize.large:
        return 52.h;
      default:
        return 40.h;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isEnabled,
      builder: (_, isEnabled, __) {
        return InkWell(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
          onTap: widget.onPressed != null ? onTap : null,
          child: AnimatedContainer(
              duration: const Duration(seconds: 3),
              width: widget.width,
              height: widget.height ?? height(),
              child: _buildButton(isEnabled)),
        );
      },
    );
  }

  Widget _buildButton(bool enabled) {
    Color fontColor = widget.fontColor ??
        (enabled
            ? widget.isOutlined
                ? Theme.of(context).primaryColor
                : AppColors.whiteColor
            : AppColors.grey[600]);
    return Container(
      margin: EdgeInsets.zero,
      padding: widget.padding ??
          EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: enabled
            ? widget.isOutlined
                ? Colors.transparent
                : (widget.color ?? Theme.of(context).primaryColor)
            : widget.disableColor ??
                (AppColors.grey[300].withValues(alpha: .3)),
        border: Border.all(
            color: enabled
                ? (widget.borderColor ?? Theme.of(context).primaryColor)
                : widget.disableBorderColor ?? (AppColors.secondary)),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FittedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.isLoading) ...[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: fontColor,
                          strokeWidth: 2.0,
                        ),
                      ),
                    )
                  ] else ...[
                    if (widget.prefixIcon != null) ...[
                      widget.prefixIcon!,
                      SizedBox(width: widget.iconAndTextGap?.w ?? 5.w),
                    ],
                    TextWidget(
                      widget.buttonText,
                      color: fontColor,
                      textType: TextType.custom,
                      textOptions: TextOptions(
                        //! maintain with button size by default
                        fontSize: widget.fontSize ??
                            (widget.buttonSize == ButtonSize.small
                                ? 14.sp
                                : widget.buttonSize == ButtonSize.large
                                    ? 18.sp
                                    : 16.sp),
                        fontWeight: widget.fontWeight ?? FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    if (widget.suffixIcon != null) ...[
                      SizedBox(width: widget.iconAndTextGap?.w ?? 5.w),
                      widget.suffixIcon!,
                    ],
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onTap() {
    if (!widget.isLoading) {
      if (widget.enabled) {
        if (widget.onPressed != null) widget.onPressed!();
      } else {
        if (widget.disableMessage != null) {}
      }
    }
  }
}
