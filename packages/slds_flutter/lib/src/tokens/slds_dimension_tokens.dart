import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';

/// SLDS dimension tokens.
///
/// All values are exposed as `final` fields so the class supports [copyWith].
/// Override individual dimensions at the token-set level or use per-component
/// `style` objects for finer control.
///
/// Defaults are the Figma-derived SLDS Alpha measurements (375×812 reference
/// frame), scaled to the current device via `flutter_screenutil` so every
/// component stays proportionally correct on any screen size:
/// - widths scale with `.w`, heights with `.h`.
/// - sizes that must stay square (radii, icons, avatars, touch targets,
///   spacing) scale with `.r`, which uses `min(scaleWidth, scaleHeight)` so
///   they never distort on unusual aspect ratios.
/// - alpha channels, hairline border/stroke widths, and shadow parameters are
///   intentionally left unscaled: alphas aren't physical dimensions, and
///   borders/shadows are kept crisp and visually consistent across devices
///   rather than growing with the screen.
///
/// Because scaling happens at construction time, an [SldsDimensionTokens]
/// (and any [SldsTokenSet] holding one) must be created after
/// `ScreenUtilInit` has run — this is already true for `context.slds` since
/// [SldsTheme] is built inside the app's `ScreenUtilInit` builder.
class SldsDimensionTokens {
  /// Creates dimension tokens, scaling Figma-derived defaults via
  /// `flutter_screenutil`. Pass an explicit value to pin a dimension and
  /// skip scaling for it.
  SldsDimensionTokens({
    double? space0,
    double? space1,
    double? space2,
    double? space4,
    double? space6,
    double? space8,
    double? space12,
    double? space16,
    double? space20,
    double? space24,
    double? space32,
    double? space10,
    double? space40,
    double? space48,
    double? space56,
    double? space64,
    double? space72,
    double? space96,
    double? space128,
    this.radiusNone = 0,
    double? radiusMd,
    double? radiusXl,
    double? radius2xl,
    double? radius3xl,
    double? radius4xl,
    double? radiusSm,
    double? radiusLg,
    this.radiusFull = 9999,
    double? buttonHeightSmall,
    double? buttonHeightMedium,
    double? buttonHeightLarge,
    double? buttonHeightExtraLarge,
    double? inputWidth,
    double? inputHeight,
    double? textAreaHeight,
    double? checkboxDefault,
    double? checkboxLarge,
    double? radioDefault,
    double? radioLarge,
    double? toggleWidth,
    double? toggleHeight,
    double? toggleThumb,
    double? cardImageHeight,
    double? dialogWidth,
    double? snackbarWidth,
    double? tabStripWidth,
    double? tabBadgeMinWidth,
    double? listItemWidth,
    double? listSlotSize,
    double? progressWidth,
    double? progressSegmentHeight,
    double? stepperWidth,
    double? avatarSize20,
    double? avatarSize24,
    double? avatarSize32,
    double? avatarSize40,
    double? avatarSize48,
    double? avatarSize56,
    double? avatarIconSmall,
    double? avatarIconMedium,
    double? avatarIconLarge,
    double? avatarIconExtraLarge,
    double? tooltipWidth,
    double? tooltipTitleWidth,
    double? tooltipArrowWidth,
    double? tooltipArrowHeight,
    double? paginationItemSize,
    double? navigationDrawerWidth,
    double? tapTargetMin,
    this.transparentAlpha = 0,
    this.elevationAlpha = 31,
    this.raisedAlpha = 13,
    this.controlBorderWidth = 1,
    this.emphasizedBorderWidth = 1.5,
    this.inputDisabledBorderWidth = 1.6,
    this.progressStrokeWidth = 2,
    double? focusRingSpread,
    this.elevationBlur = 15,
    this.elevationOffsetY = 10,
    this.elevationSpread = -3,
    this.cardShadowBlur = 8,
    this.cardShadowOffsetY = 2,
    double? iconButtonMedium,
    double? iconSizeMedium,
    this.snackbarShadowBlur = 7.5,
  })  : space0 = space0 ?? 0.r,
        space1 = space1 ?? 1.r,
        space2 = space2 ?? 2.r,
        space4 = space4 ?? 4.r,
        space6 = space6 ?? 6.r,
        space8 = space8 ?? 8.r,
        space12 = space12 ?? 12.r,
        space16 = space16 ?? 16.r,
        space20 = space20 ?? 20.r,
        space24 = space24 ?? 24.r,
        space32 = space32 ?? 32.r,
        space10 = space10 ?? 10.r,
        space40 = space40 ?? 40.r,
        space48 = space48 ?? 48.r,
        space56 = space56 ?? 56.r,
        space64 = space64 ?? 64.r,
        space72 = space72 ?? 72.r,
        space96 = space96 ?? 96.r,
        space128 = space128 ?? 128.r,
        radiusMd = radiusMd ?? 4.r,
        radiusXl = radiusXl ?? 8.r,
        radius2xl = radius2xl ?? 12.r,
        radius3xl = radius3xl ?? 16.r,
        radius4xl = radius4xl ?? 24.r,
        buttonHeightSmall = buttonHeightSmall ?? 28.h,
        buttonHeightMedium = buttonHeightMedium ?? 36.h,
        buttonHeightLarge = buttonHeightLarge ?? 48.h,
        buttonHeightExtraLarge = buttonHeightExtraLarge ?? 56.h,
        inputWidth = inputWidth ?? 361.w,
        radiusSm = radiusSm ?? 2.r,
        radiusLg = radiusLg ?? 6.r,
        inputHeight = inputHeight ?? 52.h,
        textAreaHeight = textAreaHeight ?? 128.h,
        checkboxDefault = checkboxDefault ?? 16.r,
        checkboxLarge = checkboxLarge ?? 24.r,
        radioDefault = radioDefault ?? 16.r,
        radioLarge = radioLarge ?? 20.r,
        toggleWidth = toggleWidth ?? 50.4.w,
        toggleHeight = toggleHeight ?? 28.h,
        toggleThumb = toggleThumb ?? 22.4.r,
        cardImageHeight = cardImageHeight ?? 160.h,
        dialogWidth = dialogWidth ?? 324.w,
        snackbarWidth = snackbarWidth ?? 361.w,
        tabStripWidth = tabStripWidth ?? 451.w,
        tabBadgeMinWidth = tabBadgeMinWidth ?? 16.r,
        listItemWidth = listItemWidth ?? 400.w,
        listSlotSize = listSlotSize ?? 40.r,
        progressWidth = progressWidth ?? 339.w,
        progressSegmentHeight = progressSegmentHeight ?? 6.h,
        stepperWidth = stepperWidth ?? 393.w,
        avatarSize20 = avatarSize20 ?? 20.r,
        avatarSize24 = avatarSize24 ?? 24.r,
        avatarSize32 = avatarSize32 ?? 32.r,
        avatarSize40 = avatarSize40 ?? 40.r,
        avatarSize48 = avatarSize48 ?? 48.r,
        avatarSize56 = avatarSize56 ?? 56.r,
        avatarIconSmall = avatarIconSmall ?? 14.r,
        avatarIconMedium = avatarIconMedium ?? 16.r,
        avatarIconLarge = avatarIconLarge ?? 24.r,
        avatarIconExtraLarge = avatarIconExtraLarge ?? 28.r,
        tooltipWidth = tooltipWidth ?? 320.w,
        tooltipTitleWidth = tooltipTitleWidth ?? 72.w,
        tooltipArrowWidth = tooltipArrowWidth ?? 28.w,
        tooltipArrowHeight = tooltipArrowHeight ?? 6.h,
        paginationItemSize = paginationItemSize ?? 36.r,
        navigationDrawerWidth = navigationDrawerWidth ?? 320.w,
        // Never let the accessible tap-target floor scale below the Figma
        // value (48) — WCAG/platform minimums must hold on every screen,
        // including ones shorter or narrower than the reference frame.
        tapTargetMin = tapTargetMin ?? math.max(48.0, 48.r),
        focusRingSpread = focusRingSpread ?? 3.r,
        iconButtonMedium = iconButtonMedium ?? 36.r,
        iconSizeMedium = iconSizeMedium ?? 20.r;

  final double space0;

  final double space1;

  final double space2;

  final double space4;

  final double space6;

  final double space8;

  final double space12;

  final double space16;

  final double space20;

  final double space24;

  final double space32;

  final double space10;

  final double space40;

  final double space48;

  final double space56;

  final double space64;

  final double space72;

  final double space96;

  final double space128;

  final double radiusNone;

  final double radiusMd;

  final double radiusXl;

  final double radius2xl;

  final double radius3xl;

  final double radius4xl;

  final double radiusSm;

  final double radiusLg;

  final double radiusFull;

  final double buttonHeightSmall;

  final double buttonHeightMedium;

  final double buttonHeightLarge;

  final double buttonHeightExtraLarge;

  final double inputWidth;

  final double inputHeight;

  final double textAreaHeight;

  final double checkboxDefault;

  final double checkboxLarge;

  final double radioDefault;

  final double radioLarge;

  final double toggleWidth;

  final double toggleHeight;

  final double toggleThumb;

  final double cardImageHeight;

  final double dialogWidth;

  final double snackbarWidth;

  final double tabStripWidth;

  final double tabBadgeMinWidth;

  final double listItemWidth;

  final double listSlotSize;

  final double progressWidth;

  final double progressSegmentHeight;

  final double stepperWidth;

  final double avatarSize20;

  final double avatarSize24;

  final double avatarSize32;

  final double avatarSize40;

  final double avatarSize48;

  final double avatarSize56;

  final double avatarIconSmall;

  final double avatarIconMedium;

  final double avatarIconLarge;

  final double avatarIconExtraLarge;

  final double tooltipWidth;

  final double tooltipTitleWidth;

  final double tooltipArrowWidth;

  final double tooltipArrowHeight;

  final double paginationItemSize;

  final double navigationDrawerWidth;

  final double tapTargetMin;

  final int transparentAlpha;

  final int elevationAlpha;

  final int raisedAlpha;

  final double controlBorderWidth;

  final double emphasizedBorderWidth;

  final double inputDisabledBorderWidth;

  final double progressStrokeWidth;

  final double focusRingSpread;

  final double elevationBlur;

  final double elevationOffsetY;

  final double elevationSpread;

  final double cardShadowBlur;

  final double cardShadowOffsetY;

  final double iconButtonMedium;

  final double iconSizeMedium;

  final double snackbarShadowBlur;

  SldsDimensionTokens copyWith({
    double? space0,
    double? space1,
    double? space2,
    double? space4,
    double? space6,
    double? space8,
    double? space12,
    double? space16,
    double? space20,
    double? space24,
    double? space32,
    double? space10,
    double? space40,
    double? space48,
    double? space56,
    double? space64,
    double? space72,
    double? space96,
    double? space128,
    double? radiusNone,
    double? radiusMd,
    double? radiusXl,
    double? radius2xl,
    double? radius3xl,
    double? radius4xl,
    double? radiusFull,
    double? radiusSm,
    double? radiusLg,
    double? buttonHeightSmall,
    double? buttonHeightMedium,
    double? buttonHeightLarge,
    double? buttonHeightExtraLarge,
    double? inputWidth,
    double? inputHeight,
    double? textAreaHeight,
    double? checkboxDefault,
    double? checkboxLarge,
    double? radioDefault,
    double? radioLarge,
    double? toggleWidth,
    double? toggleHeight,
    double? toggleThumb,
    double? cardImageHeight,
    double? dialogWidth,
    double? snackbarWidth,
    double? tabStripWidth,
    double? tabBadgeMinWidth,
    double? listItemWidth,
    double? listSlotSize,
    double? progressWidth,
    double? progressSegmentHeight,
    double? stepperWidth,
    double? avatarSize20,
    double? avatarSize24,
    double? avatarSize32,
    double? avatarSize40,
    double? avatarSize48,
    double? avatarSize56,
    double? avatarIconSmall,
    double? avatarIconMedium,
    double? avatarIconLarge,
    double? avatarIconExtraLarge,
    double? tooltipWidth,
    double? tooltipTitleWidth,
    double? tooltipArrowWidth,
    double? tooltipArrowHeight,
    double? paginationItemSize,
    double? navigationDrawerWidth,
    double? tapTargetMin,
    int? transparentAlpha,
    int? elevationAlpha,
    int? raisedAlpha,
    double? controlBorderWidth,
    double? emphasizedBorderWidth,
    double? inputDisabledBorderWidth,
    double? progressStrokeWidth,
    double? focusRingSpread,
    double? elevationBlur,
    double? elevationOffsetY,
    double? elevationSpread,
    double? cardShadowBlur,
    double? cardShadowOffsetY,
    double? iconButtonMedium,
    double? iconSizeMedium,
    double? snackbarShadowBlur,
  }) =>
      SldsDimensionTokens(
        space0: space0 ?? this.space0,
        space1: space1 ?? this.space1,
        space2: space2 ?? this.space2,
        space4: space4 ?? this.space4,
        space6: space6 ?? this.space6,
        space8: space8 ?? this.space8,
        space12: space12 ?? this.space12,
        space16: space16 ?? this.space16,
        space20: space20 ?? this.space20,
        space24: space24 ?? this.space24,
        space32: space32 ?? this.space32,
        space10: space10 ?? this.space10,
        space40: space40 ?? this.space40,
        space48: space48 ?? this.space48,
        space56: space56 ?? this.space56,
        space64: space64 ?? this.space64,
        space72: space72 ?? this.space72,
        space96: space96 ?? this.space96,
        space128: space128 ?? this.space128,
        radiusNone: radiusNone ?? this.radiusNone,
        radiusMd: radiusMd ?? this.radiusMd,
        radiusXl: radiusXl ?? this.radiusXl,
        radius2xl: radius2xl ?? this.radius2xl,
        radius3xl: radius3xl ?? this.radius3xl,
        radius4xl: radius4xl ?? this.radius4xl,
        radiusFull: radiusFull ?? this.radiusFull,
        radiusSm: radiusSm ?? this.radiusSm,
        radiusLg: radiusLg ?? this.radiusLg,
        buttonHeightSmall: buttonHeightSmall ?? this.buttonHeightSmall,
        buttonHeightMedium: buttonHeightMedium ?? this.buttonHeightMedium,
        buttonHeightLarge: buttonHeightLarge ?? this.buttonHeightLarge,
        buttonHeightExtraLarge:
            buttonHeightExtraLarge ?? this.buttonHeightExtraLarge,
        inputWidth: inputWidth ?? this.inputWidth,
        inputHeight: inputHeight ?? this.inputHeight,
        textAreaHeight: textAreaHeight ?? this.textAreaHeight,
        checkboxDefault: checkboxDefault ?? this.checkboxDefault,
        checkboxLarge: checkboxLarge ?? this.checkboxLarge,
        radioDefault: radioDefault ?? this.radioDefault,
        radioLarge: radioLarge ?? this.radioLarge,
        toggleWidth: toggleWidth ?? this.toggleWidth,
        toggleHeight: toggleHeight ?? this.toggleHeight,
        toggleThumb: toggleThumb ?? this.toggleThumb,
        cardImageHeight: cardImageHeight ?? this.cardImageHeight,
        dialogWidth: dialogWidth ?? this.dialogWidth,
        snackbarWidth: snackbarWidth ?? this.snackbarWidth,
        tabStripWidth: tabStripWidth ?? this.tabStripWidth,
        tabBadgeMinWidth: tabBadgeMinWidth ?? this.tabBadgeMinWidth,
        listItemWidth: listItemWidth ?? this.listItemWidth,
        listSlotSize: listSlotSize ?? this.listSlotSize,
        progressWidth: progressWidth ?? this.progressWidth,
        progressSegmentHeight:
            progressSegmentHeight ?? this.progressSegmentHeight,
        stepperWidth: stepperWidth ?? this.stepperWidth,
        avatarSize20: avatarSize20 ?? this.avatarSize20,
        avatarSize24: avatarSize24 ?? this.avatarSize24,
        avatarSize32: avatarSize32 ?? this.avatarSize32,
        avatarSize40: avatarSize40 ?? this.avatarSize40,
        avatarSize48: avatarSize48 ?? this.avatarSize48,
        avatarSize56: avatarSize56 ?? this.avatarSize56,
        avatarIconSmall: avatarIconSmall ?? this.avatarIconSmall,
        avatarIconMedium: avatarIconMedium ?? this.avatarIconMedium,
        avatarIconLarge: avatarIconLarge ?? this.avatarIconLarge,
        avatarIconExtraLarge: avatarIconExtraLarge ?? this.avatarIconExtraLarge,
        tooltipWidth: tooltipWidth ?? this.tooltipWidth,
        tooltipTitleWidth: tooltipTitleWidth ?? this.tooltipTitleWidth,
        tooltipArrowWidth: tooltipArrowWidth ?? this.tooltipArrowWidth,
        tooltipArrowHeight: tooltipArrowHeight ?? this.tooltipArrowHeight,
        paginationItemSize: paginationItemSize ?? this.paginationItemSize,
        navigationDrawerWidth:
            navigationDrawerWidth ?? this.navigationDrawerWidth,
        tapTargetMin: tapTargetMin ?? this.tapTargetMin,
        transparentAlpha: transparentAlpha ?? this.transparentAlpha,
        elevationAlpha: elevationAlpha ?? this.elevationAlpha,
        raisedAlpha: raisedAlpha ?? this.raisedAlpha,
        controlBorderWidth: controlBorderWidth ?? this.controlBorderWidth,
        emphasizedBorderWidth:
            emphasizedBorderWidth ?? this.emphasizedBorderWidth,
        inputDisabledBorderWidth:
            inputDisabledBorderWidth ?? this.inputDisabledBorderWidth,
        progressStrokeWidth: progressStrokeWidth ?? this.progressStrokeWidth,
        focusRingSpread: focusRingSpread ?? this.focusRingSpread,
        elevationBlur: elevationBlur ?? this.elevationBlur,
        elevationOffsetY: elevationOffsetY ?? this.elevationOffsetY,
        elevationSpread: elevationSpread ?? this.elevationSpread,
        cardShadowBlur: cardShadowBlur ?? this.cardShadowBlur,
        cardShadowOffsetY: cardShadowOffsetY ?? this.cardShadowOffsetY,
        iconButtonMedium: iconButtonMedium ?? this.iconButtonMedium,
        iconSizeMedium: iconSizeMedium ?? this.iconSizeMedium,
        snackbarShadowBlur: snackbarShadowBlur ?? this.snackbarShadowBlur,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SldsDimensionTokens &&
        other.space0 == space0 &&
        other.space1 == space1 &&
        other.space2 == space2 &&
        other.space4 == space4 &&
        other.space6 == space6 &&
        other.space8 == space8 &&
        other.space12 == space12 &&
        other.space16 == space16 &&
        other.space20 == space20 &&
        other.space24 == space24 &&
        other.space32 == space32 &&
        other.space10 == space10 &&
        other.space40 == space40 &&
        other.space48 == space48 &&
        other.space56 == space56 &&
        other.space64 == space64 &&
        other.space72 == space72 &&
        other.space96 == space96 &&
        other.space128 == space128 &&
        other.radiusNone == radiusNone &&
        other.radiusMd == radiusMd &&
        other.radiusXl == radiusXl &&
        other.radius2xl == radius2xl &&
        other.radius3xl == radius3xl &&
        other.radius4xl == radius4xl &&
        other.radiusFull == radiusFull &&
        other.radiusSm == radiusSm &&
        other.radiusLg == radiusLg &&
        other.buttonHeightSmall == buttonHeightSmall &&
        other.buttonHeightMedium == buttonHeightMedium &&
        other.buttonHeightLarge == buttonHeightLarge &&
        other.buttonHeightExtraLarge == buttonHeightExtraLarge &&
        other.inputWidth == inputWidth &&
        other.inputHeight == inputHeight &&
        other.textAreaHeight == textAreaHeight &&
        other.checkboxDefault == checkboxDefault &&
        other.checkboxLarge == checkboxLarge &&
        other.radioDefault == radioDefault &&
        other.radioLarge == radioLarge &&
        other.toggleWidth == toggleWidth &&
        other.toggleHeight == toggleHeight &&
        other.toggleThumb == toggleThumb &&
        other.cardImageHeight == cardImageHeight &&
        other.dialogWidth == dialogWidth &&
        other.snackbarWidth == snackbarWidth &&
        other.tabStripWidth == tabStripWidth &&
        other.tabBadgeMinWidth == tabBadgeMinWidth &&
        other.listItemWidth == listItemWidth &&
        other.listSlotSize == listSlotSize &&
        other.progressWidth == progressWidth &&
        other.progressSegmentHeight == progressSegmentHeight &&
        other.stepperWidth == stepperWidth &&
        other.avatarSize20 == avatarSize20 &&
        other.avatarSize24 == avatarSize24 &&
        other.avatarSize32 == avatarSize32 &&
        other.avatarSize40 == avatarSize40 &&
        other.avatarSize48 == avatarSize48 &&
        other.avatarSize56 == avatarSize56 &&
        other.avatarIconSmall == avatarIconSmall &&
        other.avatarIconMedium == avatarIconMedium &&
        other.avatarIconLarge == avatarIconLarge &&
        other.avatarIconExtraLarge == avatarIconExtraLarge &&
        other.tooltipWidth == tooltipWidth &&
        other.tooltipTitleWidth == tooltipTitleWidth &&
        other.tooltipArrowWidth == tooltipArrowWidth &&
        other.tooltipArrowHeight == tooltipArrowHeight &&
        other.paginationItemSize == paginationItemSize &&
        other.navigationDrawerWidth == navigationDrawerWidth &&
        other.tapTargetMin == tapTargetMin &&
        other.transparentAlpha == transparentAlpha &&
        other.elevationAlpha == elevationAlpha &&
        other.raisedAlpha == raisedAlpha &&
        other.controlBorderWidth == controlBorderWidth &&
        other.emphasizedBorderWidth == emphasizedBorderWidth &&
        other.inputDisabledBorderWidth == inputDisabledBorderWidth &&
        other.progressStrokeWidth == progressStrokeWidth &&
        other.focusRingSpread == focusRingSpread &&
        other.elevationBlur == elevationBlur &&
        other.elevationOffsetY == elevationOffsetY &&
        other.elevationSpread == elevationSpread &&
        other.cardShadowBlur == cardShadowBlur &&
        other.cardShadowOffsetY == cardShadowOffsetY &&
        other.iconButtonMedium == iconButtonMedium &&
        other.iconSizeMedium == iconSizeMedium &&
        other.snackbarShadowBlur == snackbarShadowBlur;
  }

  @override
  int get hashCode => Object.hashAll([
        space0,
        space1,
        space2,
        space4,
        space6,
        space8,
        space12,
        space16,
        space20,
        space24,
        space32,
        space10,
        space40,
        space48,
        space56,
        space64,
        space72,
        space96,
        space128,
        radiusNone,
        radiusMd,
        radiusXl,
        radius2xl,
        radius3xl,
        radius4xl,
        radiusFull,
        radiusSm,
        radiusLg,
        buttonHeightSmall,
        buttonHeightMedium,
        buttonHeightLarge,
        buttonHeightExtraLarge,
        inputWidth,
        inputHeight,
        textAreaHeight,
        checkboxDefault,
        checkboxLarge,
        radioDefault,
        radioLarge,
        toggleWidth,
        toggleHeight,
        toggleThumb,
        cardImageHeight,
        dialogWidth,
        snackbarWidth,
        tabStripWidth,
        tabBadgeMinWidth,
        listItemWidth,
        listSlotSize,
        progressWidth,
        progressSegmentHeight,
        stepperWidth,
        avatarSize20,
        avatarSize24,
        avatarSize32,
        avatarSize40,
        avatarSize48,
        avatarSize56,
        avatarIconSmall,
        avatarIconMedium,
        avatarIconLarge,
        avatarIconExtraLarge,
        tooltipWidth,
        tooltipTitleWidth,
        tooltipArrowWidth,
        tooltipArrowHeight,
        paginationItemSize,
        navigationDrawerWidth,
        tapTargetMin,
        transparentAlpha,
        elevationAlpha,
        raisedAlpha,
        controlBorderWidth,
        emphasizedBorderWidth,
        inputDisabledBorderWidth,
        progressStrokeWidth,
        focusRingSpread,
        elevationBlur,
        elevationOffsetY,
        elevationSpread,
        cardShadowBlur,
        cardShadowOffsetY,
        iconButtonMedium,
        iconSizeMedium,
        snackbarShadowBlur
      ]);
}
