import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/widgets/buttons/input_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { error, info, success, warning }
//by default is info

Color getBackgroundColor(ToastType toastType) {
  switch (toastType) {
    case ToastType.success:
      return AppColors.successColor;

    case ToastType.info:
      return AppColors.infoColor;

    case ToastType.error:
      return AppColors.errorColor;
    case ToastType.warning:
      return AppColors.warningColor;
  }
}

Color getColor(ToastType toastType) {
  switch (toastType) {
    case ToastType.success:
      return AppColors.successColor;

    case ToastType.info:
      return getIt<NavigationService>().getNavigationContext().isDark
          ? AppColors.whiteColor
          : AppColors.blackColor;

    case ToastType.error:
    case ToastType.warning:
      return AppColors.errorColor;
  }
}

/// for border
Color getBorderColor(ToastType toastType) {
  switch (toastType) {
    case ToastType.success:
      return AppColors.successColor;

    case ToastType.info:
      return AppColors.infoColor;

    case ToastType.error:
      return AppColors.errorColor;
    case ToastType.warning:
      return AppColors.warningColor;
  }
}

Color getTextColor(ToastType toastType) {
  switch (toastType) {
    case ToastType.success:
      return AppColors.whiteColor;

    case ToastType.info:
      return AppColors.whiteColor;

    case ToastType.error:
      return AppColors.whiteColor;
    case ToastType.warning:
      return AppColors.whiteColor;
  }
}

Widget getIconWidget(ToastType toastType) {
  switch (toastType) {
    case ToastType.success:
      return Icon(Icons.check_circle, color: AppColors.whiteColor);

    case ToastType.info:
      return Icon(Icons.info, color: AppColors.whiteColor);

    case ToastType.error:
      return Icon(Icons.error, color: AppColors.whiteColor);

    case ToastType.warning:
      return Icon(Icons.warning, color: AppColors.whiteColor);
  }
}

void showToast(String? message,
    {ToastType toastType = ToastType.info,
    Duration animationDuration = const Duration(milliseconds: 300),
    Duration toastDuration = const Duration(seconds: 3),
    bool showButton = false,
    String? btnTitle,
    void Function()? onPress,
    double? height,
    double? fontSize,
    ToastGravity gravity = ToastGravity.TOP}) {
  FToast fToast = FToast();
  fToast.init(getIt<NavigationService>().getNavigationContext());
  fToast.removeCustomToast();
  fToast.showToast(
    gravity: gravity,
    isDismissible: true,
    // Remove Center widget and use proper sizing
    child: Material(
      color: Colors.transparent,
      child: Container(
        // Use intrinsic dimensions instead of fixed sizing
        width: 1.sw, // Let it size itself
        constraints: BoxConstraints(
          maxWidth: 1.sw,
          minHeight: 50.h, // Minimum height for touch targets
          maxHeight: 120.h, // Maximum height to prevent overflow
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: getBackgroundColor(toastType),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: getBorderColor(toastType),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IntrinsicHeight(
          // This ensures proper height sizing
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              getIconWidget(toastType),
              8.horizontalSpace,
              Expanded(
                child: TextWidget(
                  message ?? "",
                  textType: TextType.custom,
                  textOptions: TextOptions(
                    fontSize: fontSize ?? 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  color: getTextColor(toastType),
                ),
              ),
              if (showButton) ...[
                8.horizontalSpace,
                InputButton(
                  borderColor: getColor(toastType),
                  color: getColor(toastType),
                  buttonText: btnTitle ?? "Button",
                  buttonSize: ButtonSize.small,
                  height: 30.h,
                  onPressed: onPress,
                ),
              ]
            ],
          ),
        ),
      ),
    ),
    toastDuration: toastDuration,
  );
}
