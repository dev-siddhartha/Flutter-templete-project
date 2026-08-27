import 'package:flutter/widgets.dart';

import 'slds_palette.dart';

/// Semantic color mappings for the SLDS design system.
///
/// The second layer of the 3-layer token system. Factory constructors accept a
/// [SldsPalette] and map raw swatches to semantic names. Change a palette shade
/// and every semantic token that references it updates automatically.
class SldsColorScheme {
  const SldsColorScheme({
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.surfacePage,
    required this.surfaceCard,
    required this.surfaceHover,
    required this.surfacePrimary,
    required this.borderDefault,
    required this.borderDecorative,
    required this.focusRing,
    required this.focusHalo,
    required this.buttonPrimaryBackground,
    required this.buttonPrimaryLabel,
    required this.buttonPrimaryHover,
    required this.buttonPrimaryPressed,
    required this.buttonSecondaryBackground,
    required this.buttonSecondaryLabel,
    required this.buttonSecondaryBorder,
    required this.buttonSecondaryHover,
    required this.buttonSecondaryPressed,
    required this.buttonGhostLabel,
    required this.buttonGhostHover,
    required this.buttonGhostPressed,
    required this.buttonDestructiveBackground,
    required this.buttonDestructiveLabel,
    required this.buttonDestructiveHover,
    required this.buttonDestructivePressed,
    required this.disabledBackground,
    required this.disabledForeground,
    required this.inputLabel,
    required this.inputPlaceholder,
    required this.inputHelper,
    required this.inputBorderDefault,
    required this.inputBorderFocused,
    required this.inputBorderError,
    required this.inputBorderDisabled,
    required this.error,
    required this.success,
    required this.warning,
    required this.info,
    required this.badgeSuccessText,
    required this.badgeSuccessBackground,
    required this.badgePendingText,
    required this.badgePendingBackground,
    required this.badgeErrorText,
    required this.badgeErrorBackground,
    required this.badgeInfoText,
    required this.badgeInfoBackground,
    required this.badgeNeutralText,
    required this.badgeNeutralBackground,
    required this.badgeSubmittedText,
    required this.badgeSubmittedBackground,
    required this.badgeInReviewText,
    required this.badgeInReviewBackground,
    required this.badgeApprovedText,
    required this.badgeApprovedBackground,
    required this.badgeEscalatedText,
    required this.badgeEscalatedBackground,
    required this.badgeOnHoldText,
    required this.badgeOnHoldBackground,
    required this.tooltipBackground,
    required this.tooltipText,
    required this.mastheadBackground,
    required this.cardBorder,
    required this.surfaceRaised,
    required this.badgeArchivedText,
    required this.badgeArchivedBackground,
    required this.badgeDraftText,
    required this.badgeDraftBackground,
    required this.badgeRejectedText,
    required this.badgeRejectedBackground,
    required this.inputIcon,
    required this.iconPrimary,
    required this.iconSecondary,
    required this.iconAction,
    required this.iconInverse,
    required this.tabBarBackground,
    required this.tabBarBorder,
    required this.tabBarIconActive,
    required this.tabBarIconDefault,
    required this.tabBarLabelActive,
    required this.tabBarLabelDefault,
    required this.tabBarIndicator,
    required this.textStaticWhite,
  });

  final Color textPrimary;

  final Color textSecondary;

  final Color textTertiary;

  final Color surfacePage;

  /// Card and overlay surface.
  final Color surfaceCard;

  final Color surfaceHover;

  /// Control fill surface.
  final Color surfacePrimary;

  final Color borderDefault;

  final Color borderDecorative;

  final Color focusRing;

  final Color focusHalo;

  final Color buttonPrimaryBackground;

  final Color buttonPrimaryLabel;

  final Color buttonPrimaryHover;

  final Color buttonPrimaryPressed;

  final Color buttonSecondaryBackground;

  final Color buttonSecondaryLabel;

  final Color buttonSecondaryBorder;

  final Color buttonSecondaryHover;

  final Color buttonSecondaryPressed;

  final Color buttonGhostLabel;

  final Color buttonGhostHover;

  final Color buttonGhostPressed;

  final Color buttonDestructiveBackground;

  final Color buttonDestructiveLabel;

  final Color buttonDestructiveHover;

  final Color buttonDestructivePressed;

  final Color disabledBackground;

  final Color disabledForeground;

  final Color inputLabel;

  final Color inputPlaceholder;

  final Color inputHelper;

  final Color inputBorderDefault;

  final Color inputBorderFocused;

  final Color inputBorderError;

  final Color inputBorderDisabled;

  final Color error;

  final Color success;

  final Color warning;

  final Color info;

  final Color badgeSuccessText;

  final Color badgeSuccessBackground;

  final Color badgePendingText;

  final Color badgePendingBackground;

  final Color badgeErrorText;

  final Color badgeErrorBackground;

  final Color badgeInfoText;

  final Color badgeInfoBackground;

  final Color badgeNeutralText;

  final Color badgeNeutralBackground;

  final Color badgeSubmittedText;

  final Color badgeSubmittedBackground;

  final Color badgeInReviewText;

  final Color badgeInReviewBackground;

  final Color badgeApprovedText;

  final Color badgeApprovedBackground;

  final Color badgeEscalatedText;

  final Color badgeEscalatedBackground;

  final Color badgeOnHoldText;

  final Color badgeOnHoldBackground;

  final Color tooltipBackground;

  final Color tooltipText;

  final Color mastheadBackground;

  final Color cardBorder;

  final Color surfaceRaised;

  final Color badgeArchivedText;

  final Color badgeArchivedBackground;

  final Color badgeDraftText;

  final Color badgeDraftBackground;

  final Color badgeRejectedText;

  final Color badgeRejectedBackground;

  final Color inputIcon;

  final Color iconPrimary;

  final Color iconSecondary;

  final Color iconAction;

  final Color iconInverse;

  final Color tabBarBackground;

  final Color tabBarBorder;

  final Color tabBarIconActive;

  final Color tabBarIconDefault;

  final Color tabBarLabelActive;

  final Color tabBarLabelDefault;

  final Color tabBarIndicator;

  final Color textStaticWhite;

  factory SldsColorScheme.light([
    SldsPalette palette = SldsPalette.defaultPalette,
  ]) =>
      SldsColorScheme(
        textPrimary: palette.grey[900],
        textSecondary: palette.grey[600],
        textTertiary: palette.grey[400],
        surfacePage: palette.grey[50],
        surfaceCard: palette.grey[50],
        surfaceHover: palette.grey[100],
        surfacePrimary: palette.grey[50],
        borderDefault: palette.grey[500],
        borderDecorative: palette.grey[200],
        focusRing: palette.primary[500],
        focusHalo: palette.primary[100],
        buttonPrimaryBackground: palette.primary[500],
        buttonPrimaryLabel: palette.grey[900],
        buttonPrimaryHover: palette.primary[600],
        buttonPrimaryPressed: palette.primary[600],
        buttonSecondaryBackground: palette.grey[50],
        buttonSecondaryLabel: palette.grey[900],
        buttonSecondaryBorder: palette.grey[300],
        buttonSecondaryHover: palette.grey[100],
        buttonSecondaryPressed: palette.grey[100],
        buttonGhostLabel: palette.grey[900],
        buttonGhostHover: palette.grey[100],
        buttonGhostPressed: palette.grey[100],
        buttonDestructiveBackground: palette.error[600],
        buttonDestructiveLabel: palette.grey[50],
        buttonDestructiveHover: palette.error[700],
        buttonDestructivePressed: palette.error[700],
        disabledBackground: palette.grey[200],
        disabledForeground: palette.grey[400],
        inputLabel: palette.grey[900],
        inputPlaceholder: palette.grey[400],
        inputHelper: palette.grey[600],
        inputBorderDefault: palette.grey[500],
        inputBorderFocused: palette.primary[500],
        inputBorderError: palette.error[600],
        inputBorderDisabled: palette.grey[200],
        error: palette.error[600],
        success: palette.success[600],
        warning: palette.warning[600],
        info: palette.info[500],
        badgeSuccessText: palette.success[600],
        badgeSuccessBackground: palette.success[100],
        badgePendingText: palette.warning[600],
        badgePendingBackground: palette.warning[100],
        badgeErrorText: palette.error[600],
        badgeErrorBackground: palette.error[100],
        badgeInfoText: palette.info[500],
        badgeInfoBackground: palette.grey[100],
        badgeNeutralText: palette.grey[600],
        badgeNeutralBackground: palette.grey[100],
        badgeSubmittedText: palette.info[500],
        badgeSubmittedBackground: palette.info[100],
        badgeInReviewText: palette.secondary[500],
        badgeInReviewBackground: palette.secondary[100],
        badgeApprovedText: palette.success[600],
        badgeApprovedBackground: palette.success[100],
        badgeEscalatedText: palette.warning[600],
        badgeEscalatedBackground: palette.warning[100],
        badgeOnHoldText: palette.primary[500],
        badgeOnHoldBackground: palette.primary[100],
        tooltipBackground: palette.grey[900],
        tooltipText: palette.grey[50],
        mastheadBackground: palette.grey[900],
        cardBorder: palette.grey[300],
        surfaceRaised: palette.grey[100],
        badgeArchivedText: palette.grey[400],
        badgeArchivedBackground: palette.grey[100],
        badgeDraftText: palette.grey[600],
        badgeDraftBackground: palette.grey[100],
        badgeRejectedText: palette.error[600],
        badgeRejectedBackground: palette.error[100],
        inputIcon: palette.grey[500],
        iconPrimary: palette.grey[900],
        iconSecondary: palette.grey[500],
        iconAction: palette.primary[700],
        iconInverse: palette.grey[50],
        tabBarBackground: palette.grey[50],
        tabBarBorder: palette.grey[200],
        tabBarIconActive: palette.grey[900],
        tabBarIconDefault: palette.grey[500],
        tabBarLabelActive: palette.grey[900],
        tabBarLabelDefault: palette.grey[600],
        tabBarIndicator: palette.primary[500],
        textStaticWhite: palette.grey[50],
      );

  factory SldsColorScheme.dark([
    SldsPalette palette = SldsPalette.defaultPalette,
  ]) =>
      SldsColorScheme(
        textPrimary: palette.grey[50],
        textSecondary: palette.grey[400],
        textTertiary: palette.grey[600],
        surfacePage: palette.grey[900],
        surfaceCard: palette.grey[800],
        surfaceHover: palette.grey[800],
        surfacePrimary: palette.grey[800],
        borderDefault: palette.grey[700],
        borderDecorative: palette.grey[700],
        focusRing: palette.primary[600],
        focusHalo: palette.primary[100],
        buttonPrimaryBackground: palette.primary[500],
        buttonPrimaryLabel: palette.grey[900],
        buttonPrimaryHover: palette.primary[400],
        buttonPrimaryPressed: palette.primary[400],
        buttonSecondaryBackground: palette.grey[800],
        buttonSecondaryLabel: palette.grey[50],
        buttonSecondaryBorder: palette.grey[800],
        buttonSecondaryHover: palette.grey[800],
        buttonSecondaryPressed: palette.grey[800],
        buttonGhostLabel: palette.grey[50],
        buttonGhostHover: palette.grey[800],
        buttonGhostPressed: palette.grey[800],
        buttonDestructiveBackground: palette.error[600],
        buttonDestructiveLabel: palette.grey[50],
        buttonDestructiveHover: palette.error[700],
        buttonDestructivePressed: palette.error[700],
        disabledBackground: palette.grey[800],
        disabledForeground: palette.grey[600],
        inputLabel: palette.grey[50],
        inputPlaceholder: palette.grey[600],
        inputHelper: palette.grey[400],
        inputBorderDefault: palette.grey[700],
        inputBorderFocused: palette.primary[600],
        inputBorderError: palette.error[400],
        inputBorderDisabled: palette.grey[700],
        error: palette.error[400],
        success: palette.success[400],
        warning: palette.warning[400],
        info: palette.info[300],
        badgeSuccessText: palette.success[400],
        badgeSuccessBackground: palette.success[900],
        badgePendingText: palette.warning[400],
        badgePendingBackground: palette.warning[900],
        badgeErrorText: palette.error[400],
        badgeErrorBackground: palette.error[900],
        badgeInfoText: palette.info[300],
        badgeInfoBackground: palette.info[900],
        badgeNeutralText: palette.grey[400],
        badgeNeutralBackground: palette.grey[800],
        badgeSubmittedText: palette.info[300],
        badgeSubmittedBackground: palette.info[900],
        badgeInReviewText: palette.secondary[300],
        badgeInReviewBackground: palette.secondary[900],
        badgeApprovedText: palette.success[400],
        badgeApprovedBackground: palette.success[900],
        badgeEscalatedText: palette.warning[400],
        badgeEscalatedBackground: palette.warning[900],
        badgeOnHoldText: palette.primary[300],
        badgeOnHoldBackground: palette.primary[900],
        tooltipBackground: palette.grey[50],
        tooltipText: palette.grey[900],
        mastheadBackground: palette.grey[900],
        cardBorder: palette.grey[700],
        surfaceRaised: palette.grey[700],
        badgeArchivedText: palette.grey[600],
        badgeArchivedBackground: palette.grey[900],
        badgeDraftText: palette.grey[400],
        badgeDraftBackground: palette.warning[900],
        badgeRejectedText: palette.error[400],
        badgeRejectedBackground: palette.error[900],
        inputIcon: palette.grey[400],
        iconPrimary: palette.grey[50],
        iconSecondary: palette.grey[400],
        iconAction: palette.primary[700],
        iconInverse: palette.grey[900],
        tabBarBackground: palette.grey[900],
        tabBarBorder: palette.grey[700],
        tabBarIconActive: palette.grey[50],
        tabBarIconDefault: palette.grey[400],
        tabBarLabelActive: palette.grey[50],
        tabBarLabelDefault: palette.grey[400],
        tabBarIndicator: palette.primary[500],
        textStaticWhite: palette.grey[50],
      );

  factory SldsColorScheme.highContrast([
    SldsPalette palette = SldsPalette.defaultPalette,
  ]) =>
      SldsColorScheme(
        textPrimary: palette.grey[900],
        textSecondary: palette.grey[900],
        textTertiary: palette.grey[900],
        surfacePage: palette.grey[50],
        surfaceCard: palette.grey[50],
        surfaceHover: palette.grey[200],
        surfacePrimary: palette.grey[50],
        borderDefault: palette.grey[900],
        borderDecorative: palette.grey[900],
        focusRing: palette.grey[900],
        focusHalo: palette.grey[900],
        buttonPrimaryBackground: palette.primary[500],
        buttonPrimaryLabel: palette.grey[900],
        buttonPrimaryHover: palette.primary[600],
        buttonPrimaryPressed: palette.primary[700],
        buttonSecondaryBackground: palette.grey[50],
        buttonSecondaryLabel: palette.grey[900],
        buttonSecondaryBorder: palette.grey[900],
        buttonSecondaryHover: palette.grey[200],
        buttonSecondaryPressed: palette.grey[200],
        buttonGhostLabel: palette.grey[900],
        buttonGhostHover: palette.grey[200],
        buttonGhostPressed: palette.grey[200],
        buttonDestructiveBackground: palette.error[700],
        buttonDestructiveLabel: palette.grey[50],
        buttonDestructiveHover: palette.error[800],
        buttonDestructivePressed: palette.error[900],
        disabledBackground: palette.grey[100],
        disabledForeground: palette.grey[600],
        inputLabel: palette.grey[900],
        inputPlaceholder: palette.grey[600],
        inputHelper: palette.grey[900],
        inputBorderDefault: palette.grey[900],
        inputBorderFocused: palette.grey[900],
        inputBorderError: palette.grey[900],
        inputBorderDisabled: palette.grey[600],
        error: palette.error[700],
        success: palette.success[800],
        warning: palette.warning[800],
        info: palette.info[500],
        badgeSuccessText: palette.success[800],
        badgeSuccessBackground: palette.grey[50],
        badgePendingText: palette.warning[800],
        badgePendingBackground: palette.grey[50],
        badgeErrorText: palette.error[700],
        badgeErrorBackground: palette.grey[50],
        badgeInfoText: palette.info[500],
        badgeInfoBackground: palette.grey[50],
        badgeNeutralText: palette.grey[900],
        badgeNeutralBackground: palette.grey[50],
        badgeSubmittedText: palette.info[500],
        badgeSubmittedBackground: palette.grey[50],
        badgeInReviewText: palette.secondary[900],
        badgeInReviewBackground: palette.grey[50],
        badgeApprovedText: palette.success[800],
        badgeApprovedBackground: palette.grey[50],
        badgeEscalatedText: palette.warning[900],
        badgeEscalatedBackground: palette.grey[50],
        badgeOnHoldText: palette.primary[900],
        badgeOnHoldBackground: palette.grey[50],
        tooltipBackground: palette.grey[900],
        tooltipText: palette.grey[50],
        mastheadBackground: palette.grey[900],
        cardBorder: palette.grey[900],
        surfaceRaised: palette.grey[200],
        badgeArchivedText: palette.grey[700],
        badgeArchivedBackground: palette.grey[50],
        badgeDraftText: palette.grey[700],
        badgeDraftBackground: palette.grey[50],
        badgeRejectedText: palette.error[700],
        badgeRejectedBackground: palette.grey[50],
        inputIcon: palette.grey[900],
        iconPrimary: palette.grey[900],
        iconSecondary: palette.grey[900],
        iconAction: palette.grey[900],
        iconInverse: palette.grey[50],
        tabBarBackground: palette.grey[50],
        tabBarBorder: palette.grey[900],
        tabBarIconActive: palette.grey[900],
        tabBarIconDefault: palette.grey[900],
        tabBarLabelActive: palette.grey[900],
        tabBarLabelDefault: palette.grey[900],
        tabBarIndicator: palette.primary[500],
        textStaticWhite: palette.grey[50],
      );

  SldsColorScheme copyWith({
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? surfacePage,
    Color? surfaceCard,
    Color? surfaceHover,
    Color? surfacePrimary,
    Color? borderDefault,
    Color? borderDecorative,
    Color? focusRing,
    Color? focusHalo,
    Color? buttonPrimaryBackground,
    Color? buttonPrimaryLabel,
    Color? buttonPrimaryHover,
    Color? buttonPrimaryPressed,
    Color? buttonSecondaryBackground,
    Color? buttonSecondaryLabel,
    Color? buttonSecondaryBorder,
    Color? buttonSecondaryHover,
    Color? buttonSecondaryPressed,
    Color? buttonGhostLabel,
    Color? buttonGhostHover,
    Color? buttonGhostPressed,
    Color? buttonDestructiveBackground,
    Color? buttonDestructiveLabel,
    Color? buttonDestructiveHover,
    Color? buttonDestructivePressed,
    Color? disabledBackground,
    Color? disabledForeground,
    Color? inputLabel,
    Color? inputPlaceholder,
    Color? inputHelper,
    Color? inputBorderDefault,
    Color? inputBorderFocused,
    Color? inputBorderError,
    Color? inputBorderDisabled,
    Color? error,
    Color? success,
    Color? warning,
    Color? info,
    Color? badgeSuccessText,
    Color? badgeSuccessBackground,
    Color? badgePendingText,
    Color? badgePendingBackground,
    Color? badgeErrorText,
    Color? badgeErrorBackground,
    Color? badgeInfoText,
    Color? badgeInfoBackground,
    Color? badgeNeutralText,
    Color? badgeNeutralBackground,
    Color? badgeSubmittedText,
    Color? badgeSubmittedBackground,
    Color? badgeInReviewText,
    Color? badgeInReviewBackground,
    Color? badgeApprovedText,
    Color? badgeApprovedBackground,
    Color? badgeEscalatedText,
    Color? badgeEscalatedBackground,
    Color? badgeOnHoldText,
    Color? badgeOnHoldBackground,
    Color? tooltipBackground,
    Color? tooltipText,
    Color? mastheadBackground,
    Color? cardBorder,
    Color? surfaceRaised,
    Color? badgeArchivedText,
    Color? badgeArchivedBackground,
    Color? badgeDraftText,
    Color? badgeDraftBackground,
    Color? badgeRejectedText,
    Color? badgeRejectedBackground,
    Color? inputIcon,
    Color? iconPrimary,
    Color? iconSecondary,
    Color? iconAction,
    Color? iconInverse,
    Color? tabBarBackground,
    Color? tabBarBorder,
    Color? tabBarIconActive,
    Color? tabBarIconDefault,
    Color? tabBarLabelActive,
    Color? tabBarLabelDefault,
    Color? tabBarIndicator,
    Color? textStaticWhite,
  }) =>
      SldsColorScheme(
        textPrimary: textPrimary ?? this.textPrimary,
        textSecondary: textSecondary ?? this.textSecondary,
        textTertiary: textTertiary ?? this.textTertiary,
        surfacePage: surfacePage ?? this.surfacePage,
        surfaceCard: surfaceCard ?? this.surfaceCard,
        surfaceHover: surfaceHover ?? this.surfaceHover,
        surfacePrimary: surfacePrimary ?? this.surfacePrimary,
        borderDefault: borderDefault ?? this.borderDefault,
        borderDecorative: borderDecorative ?? this.borderDecorative,
        focusRing: focusRing ?? this.focusRing,
        focusHalo: focusHalo ?? this.focusHalo,
        buttonPrimaryBackground:
            buttonPrimaryBackground ?? this.buttonPrimaryBackground,
        buttonPrimaryLabel: buttonPrimaryLabel ?? this.buttonPrimaryLabel,
        buttonPrimaryHover: buttonPrimaryHover ?? this.buttonPrimaryHover,
        buttonPrimaryPressed: buttonPrimaryPressed ?? this.buttonPrimaryPressed,
        buttonSecondaryBackground:
            buttonSecondaryBackground ?? this.buttonSecondaryBackground,
        buttonSecondaryLabel: buttonSecondaryLabel ?? this.buttonSecondaryLabel,
        buttonSecondaryBorder:
            buttonSecondaryBorder ?? this.buttonSecondaryBorder,
        buttonSecondaryHover: buttonSecondaryHover ?? this.buttonSecondaryHover,
        buttonSecondaryPressed:
            buttonSecondaryPressed ?? this.buttonSecondaryPressed,
        buttonGhostLabel: buttonGhostLabel ?? this.buttonGhostLabel,
        buttonGhostHover: buttonGhostHover ?? this.buttonGhostHover,
        buttonGhostPressed: buttonGhostPressed ?? this.buttonGhostPressed,
        buttonDestructiveBackground:
            buttonDestructiveBackground ?? this.buttonDestructiveBackground,
        buttonDestructiveLabel:
            buttonDestructiveLabel ?? this.buttonDestructiveLabel,
        buttonDestructiveHover:
            buttonDestructiveHover ?? this.buttonDestructiveHover,
        buttonDestructivePressed:
            buttonDestructivePressed ?? this.buttonDestructivePressed,
        disabledBackground: disabledBackground ?? this.disabledBackground,
        disabledForeground: disabledForeground ?? this.disabledForeground,
        inputLabel: inputLabel ?? this.inputLabel,
        inputPlaceholder: inputPlaceholder ?? this.inputPlaceholder,
        inputHelper: inputHelper ?? this.inputHelper,
        inputBorderDefault: inputBorderDefault ?? this.inputBorderDefault,
        inputBorderFocused: inputBorderFocused ?? this.inputBorderFocused,
        inputBorderError: inputBorderError ?? this.inputBorderError,
        inputBorderDisabled: inputBorderDisabled ?? this.inputBorderDisabled,
        error: error ?? this.error,
        success: success ?? this.success,
        warning: warning ?? this.warning,
        info: info ?? this.info,
        badgeSuccessText: badgeSuccessText ?? this.badgeSuccessText,
        badgeSuccessBackground:
            badgeSuccessBackground ?? this.badgeSuccessBackground,
        badgePendingText: badgePendingText ?? this.badgePendingText,
        badgePendingBackground:
            badgePendingBackground ?? this.badgePendingBackground,
        badgeErrorText: badgeErrorText ?? this.badgeErrorText,
        badgeErrorBackground: badgeErrorBackground ?? this.badgeErrorBackground,
        badgeInfoText: badgeInfoText ?? this.badgeInfoText,
        badgeInfoBackground: badgeInfoBackground ?? this.badgeInfoBackground,
        badgeNeutralText: badgeNeutralText ?? this.badgeNeutralText,
        badgeNeutralBackground:
            badgeNeutralBackground ?? this.badgeNeutralBackground,
        badgeSubmittedText: badgeSubmittedText ?? this.badgeSubmittedText,
        badgeSubmittedBackground:
            badgeSubmittedBackground ?? this.badgeSubmittedBackground,
        badgeInReviewText: badgeInReviewText ?? this.badgeInReviewText,
        badgeInReviewBackground:
            badgeInReviewBackground ?? this.badgeInReviewBackground,
        badgeApprovedText: badgeApprovedText ?? this.badgeApprovedText,
        badgeApprovedBackground:
            badgeApprovedBackground ?? this.badgeApprovedBackground,
        badgeEscalatedText: badgeEscalatedText ?? this.badgeEscalatedText,
        badgeEscalatedBackground:
            badgeEscalatedBackground ?? this.badgeEscalatedBackground,
        badgeOnHoldText: badgeOnHoldText ?? this.badgeOnHoldText,
        badgeOnHoldBackground:
            badgeOnHoldBackground ?? this.badgeOnHoldBackground,
        tooltipBackground: tooltipBackground ?? this.tooltipBackground,
        tooltipText: tooltipText ?? this.tooltipText,
        mastheadBackground: mastheadBackground ?? this.mastheadBackground,
        cardBorder: cardBorder ?? this.cardBorder,
        surfaceRaised: surfaceRaised ?? this.surfaceRaised,
        badgeArchivedText: badgeArchivedText ?? this.badgeArchivedText,
        badgeArchivedBackground:
            badgeArchivedBackground ?? this.badgeArchivedBackground,
        badgeDraftText: badgeDraftText ?? this.badgeDraftText,
        badgeDraftBackground: badgeDraftBackground ?? this.badgeDraftBackground,
        badgeRejectedText: badgeRejectedText ?? this.badgeRejectedText,
        badgeRejectedBackground:
            badgeRejectedBackground ?? this.badgeRejectedBackground,
        inputIcon: inputIcon ?? this.inputIcon,
        iconPrimary: iconPrimary ?? this.iconPrimary,
        iconSecondary: iconSecondary ?? this.iconSecondary,
        iconAction: iconAction ?? this.iconAction,
        iconInverse: iconInverse ?? this.iconInverse,
        tabBarBackground: tabBarBackground ?? this.tabBarBackground,
        tabBarBorder: tabBarBorder ?? this.tabBarBorder,
        tabBarIconActive: tabBarIconActive ?? this.tabBarIconActive,
        tabBarIconDefault: tabBarIconDefault ?? this.tabBarIconDefault,
        tabBarLabelActive: tabBarLabelActive ?? this.tabBarLabelActive,
        tabBarLabelDefault: tabBarLabelDefault ?? this.tabBarLabelDefault,
        tabBarIndicator: tabBarIndicator ?? this.tabBarIndicator,
        textStaticWhite: textStaticWhite ?? this.textStaticWhite,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SldsColorScheme &&
        other.textPrimary == textPrimary &&
        other.textSecondary == textSecondary &&
        other.textTertiary == textTertiary &&
        other.surfacePage == surfacePage &&
        other.surfaceCard == surfaceCard &&
        other.surfaceHover == surfaceHover &&
        other.surfacePrimary == surfacePrimary &&
        other.borderDefault == borderDefault &&
        other.borderDecorative == borderDecorative &&
        other.focusRing == focusRing &&
        other.focusHalo == focusHalo &&
        other.buttonPrimaryBackground == buttonPrimaryBackground &&
        other.buttonPrimaryLabel == buttonPrimaryLabel &&
        other.buttonPrimaryHover == buttonPrimaryHover &&
        other.buttonPrimaryPressed == buttonPrimaryPressed &&
        other.buttonSecondaryBackground == buttonSecondaryBackground &&
        other.buttonSecondaryLabel == buttonSecondaryLabel &&
        other.buttonSecondaryBorder == buttonSecondaryBorder &&
        other.buttonSecondaryHover == buttonSecondaryHover &&
        other.buttonSecondaryPressed == buttonSecondaryPressed &&
        other.buttonGhostLabel == buttonGhostLabel &&
        other.buttonGhostHover == buttonGhostHover &&
        other.buttonGhostPressed == buttonGhostPressed &&
        other.buttonDestructiveBackground == buttonDestructiveBackground &&
        other.buttonDestructiveLabel == buttonDestructiveLabel &&
        other.buttonDestructiveHover == buttonDestructiveHover &&
        other.buttonDestructivePressed == buttonDestructivePressed &&
        other.disabledBackground == disabledBackground &&
        other.disabledForeground == disabledForeground &&
        other.inputLabel == inputLabel &&
        other.inputPlaceholder == inputPlaceholder &&
        other.inputHelper == inputHelper &&
        other.inputBorderDefault == inputBorderDefault &&
        other.inputBorderFocused == inputBorderFocused &&
        other.inputBorderError == inputBorderError &&
        other.inputBorderDisabled == inputBorderDisabled &&
        other.error == error &&
        other.success == success &&
        other.warning == warning &&
        other.info == info &&
        other.badgeSuccessText == badgeSuccessText &&
        other.badgeSuccessBackground == badgeSuccessBackground &&
        other.badgePendingText == badgePendingText &&
        other.badgePendingBackground == badgePendingBackground &&
        other.badgeErrorText == badgeErrorText &&
        other.badgeErrorBackground == badgeErrorBackground &&
        other.badgeInfoText == badgeInfoText &&
        other.badgeInfoBackground == badgeInfoBackground &&
        other.badgeNeutralText == badgeNeutralText &&
        other.badgeNeutralBackground == badgeNeutralBackground &&
        other.badgeSubmittedText == badgeSubmittedText &&
        other.badgeSubmittedBackground == badgeSubmittedBackground &&
        other.badgeInReviewText == badgeInReviewText &&
        other.badgeInReviewBackground == badgeInReviewBackground &&
        other.badgeApprovedText == badgeApprovedText &&
        other.badgeApprovedBackground == badgeApprovedBackground &&
        other.badgeEscalatedText == badgeEscalatedText &&
        other.badgeEscalatedBackground == badgeEscalatedBackground &&
        other.badgeOnHoldText == badgeOnHoldText &&
        other.badgeOnHoldBackground == badgeOnHoldBackground &&
        other.tooltipBackground == tooltipBackground &&
        other.tooltipText == tooltipText &&
        other.mastheadBackground == mastheadBackground &&
        other.cardBorder == cardBorder &&
        other.surfaceRaised == surfaceRaised &&
        other.badgeArchivedText == badgeArchivedText &&
        other.badgeArchivedBackground == badgeArchivedBackground &&
        other.badgeDraftText == badgeDraftText &&
        other.badgeDraftBackground == badgeDraftBackground &&
        other.badgeRejectedText == badgeRejectedText &&
        other.badgeRejectedBackground == badgeRejectedBackground &&
        other.inputIcon == inputIcon &&
        other.iconPrimary == iconPrimary &&
        other.iconSecondary == iconSecondary &&
        other.iconAction == iconAction &&
        other.iconInverse == iconInverse &&
        other.tabBarBackground == tabBarBackground &&
        other.tabBarBorder == tabBarBorder &&
        other.tabBarIconActive == tabBarIconActive &&
        other.tabBarIconDefault == tabBarIconDefault &&
        other.tabBarLabelActive == tabBarLabelActive &&
        other.tabBarLabelDefault == tabBarLabelDefault &&
        other.tabBarIndicator == tabBarIndicator &&
        other.textStaticWhite == textStaticWhite;
  }

  @override
  int get hashCode => Object.hashAll([
        textPrimary,
        textSecondary,
        textTertiary,
        surfacePage,
        surfaceCard,
        surfaceHover,
        surfacePrimary,
        borderDefault,
        borderDecorative,
        focusRing,
        focusHalo,
        buttonPrimaryBackground,
        buttonPrimaryLabel,
        buttonPrimaryHover,
        buttonPrimaryPressed,
        buttonSecondaryBackground,
        buttonSecondaryLabel,
        buttonSecondaryBorder,
        buttonSecondaryHover,
        buttonSecondaryPressed,
        buttonGhostLabel,
        buttonGhostHover,
        buttonGhostPressed,
        buttonDestructiveBackground,
        buttonDestructiveLabel,
        buttonDestructiveHover,
        buttonDestructivePressed,
        disabledBackground,
        disabledForeground,
        inputLabel,
        inputPlaceholder,
        inputHelper,
        inputBorderDefault,
        inputBorderFocused,
        inputBorderError,
        inputBorderDisabled,
        error,
        success,
        warning,
        info,
        badgeSuccessText,
        badgeSuccessBackground,
        badgePendingText,
        badgePendingBackground,
        badgeErrorText,
        badgeErrorBackground,
        badgeInfoText,
        badgeInfoBackground,
        badgeNeutralText,
        badgeNeutralBackground,
        badgeSubmittedText,
        badgeSubmittedBackground,
        badgeInReviewText,
        badgeInReviewBackground,
        badgeApprovedText,
        badgeApprovedBackground,
        badgeEscalatedText,
        badgeEscalatedBackground,
        badgeOnHoldText,
        badgeOnHoldBackground,
        tooltipBackground,
        tooltipText,
        mastheadBackground,
        cardBorder,
        surfaceRaised,
        badgeArchivedText,
        badgeArchivedBackground,
        badgeDraftText,
        badgeDraftBackground,
        badgeRejectedText,
        badgeRejectedBackground,
        inputIcon,
        iconPrimary,
        iconSecondary,
        iconAction,
        iconInverse,
        tabBarBackground,
        tabBarBorder,
        tabBarIconActive,
        tabBarIconDefault,
        tabBarLabelActive,
        tabBarLabelDefault,
        tabBarIndicator,
        textStaticWhite,
      ]);
}
