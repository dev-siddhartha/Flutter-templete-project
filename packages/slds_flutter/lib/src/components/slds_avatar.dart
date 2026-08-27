import 'package:flutter/material.dart';
import 'package:slds_flutter/slds_flutter.dart';

import 'slds_focus.dart';

/// Avatar sizes from the Figma Display & Data page.
enum SldsAvatarSize {
  /// 20px.
  size20,

  /// 24px.
  size24,

  /// 32px.
  size32,

  /// 40px.
  size40,

  /// 48px.
  size48,

  /// 56px.
  size56,
}

/// Figma-backed SLDS avatar. Defaults to initials "LK" if nothing is provided.
class SldsAvatar extends StatelessWidget {
  const SldsAvatar(
      {super.key,
      this.image,
      this.initials,
      this.icon,
      this.semanticLabel,
      this.size = SldsAvatarSize.size32,
      this.style,
      this.state})
      : assert(
          ((image != null ? 1 : 0) +
                  (icon != null ? 1 : 0) +
                  (initials != null ? 1 : 0)) <=
              1,
          'SldsAvatar accepts at most one content source: '
          'image, icon, or initals. '
          'If none is provided, it defaults to initials "LK".',
        );

  final ImageProvider? image;

  /// Defaults to 'LK' when not provided.
  final String? initials;

  final IconData? icon;

  final String? semanticLabel;

  final SldsAvatarSize size;

  final SldsAvatarStyle? style;

  final SldsComponentState? state;

  String get _effectiveInitials =>
      (initials?.trim().isNotEmpty ?? false) ? initials!.trim() : 'LK';
  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final dimension = _dimension(context);
    final colors = _AvatarColors.resolve(context, state);

    final effectiveBg = style?.backgroundColor ??
        (image != null
            ? tokens.colors.surfaceCard.withAlpha(
                tokens.dimensions.transparentAlpha,
              )
            : colors.background);

    final effectiveFg = style?.foregroundColor ?? colors.foreground;
    final effectiveBorderColor = style?.borderColor ?? colors.border;
    final effectiveBorderWidth = style?.borderWidth ?? 1.0;
    final effectiveInitialsStyle = style?.initialsStyle ??
        _textStyle(context).copyWith(color: effectiveFg);

    return Semantics(
      image: image != null,
      label: semanticLabel,
      child: Container(
        width: dimension,
        height: dimension,
        decoration: BoxDecoration(
          color: effectiveBg,
          shape: BoxShape.circle,
          border: Border.all(
              color: effectiveBorderColor, width: effectiveBorderWidth),
          boxShadow:
              state == SldsComponentState.focus ? sldsFocusRing(tokens) : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: Center(
            child: _buildAvatar(
                tokens, context, effectiveFg, effectiveInitialsStyle)),
      ),
    );
  }

  Widget _buildAvatar(SldsTokenSet tokens, BuildContext context,
      Color effectiveFg, TextStyle effectiveInitialsStyle) {
    if (state == SldsComponentState.loading) {
      return SizedBox.square(
        dimension: _dimension(context),
        child: CircularProgressIndicator(
          strokeWidth: tokens.dimensions.progressStrokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(effectiveFg),
        ),
      );
    } else if (image != null) {
      return Image(
        image: image!,
        width: _dimension(context),
        height: _dimension(context),
        fit: BoxFit.cover,
      );
    } else if (icon != null) {
      return Icon(
        icon,
        size: _iconDimension(context),
        color: effectiveFg,
      );
    } else {
      return Text(
        _effectiveInitials,
        style: effectiveInitialsStyle,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
  }

  double _dimension(BuildContext context) {
    final d = context.slds.dimensions;
    switch (size) {
      case SldsAvatarSize.size20:
        return d.avatarSize20;
      case SldsAvatarSize.size24:
        return d.avatarSize24;
      case SldsAvatarSize.size32:
        return d.avatarSize32;
      case SldsAvatarSize.size40:
        return d.avatarSize40;
      case SldsAvatarSize.size48:
        return d.avatarSize48;
      case SldsAvatarSize.size56:
        return d.avatarSize56;
    }
  }

  double _iconDimension(BuildContext context) {
    final d = context.slds.dimensions;
    switch (size) {
      case SldsAvatarSize.size20:
        return d.avatarIconSmall;
      case SldsAvatarSize.size24:
        return d.avatarIconMedium;
      case SldsAvatarSize.size32:
        return d.iconSizeMedium;
      case SldsAvatarSize.size40:
      case SldsAvatarSize.size48:
        return d.avatarIconLarge;
      case SldsAvatarSize.size56:
        return d.avatarIconExtraLarge;
    }
  }

  TextStyle _textStyle(BuildContext context) {
    final t = context.slds.typography;
    switch (size) {
      case SldsAvatarSize.size20:
      case SldsAvatarSize.size24:
        return t.caption1;
      case SldsAvatarSize.size32:
        return t.body1;
      case SldsAvatarSize.size40:
        return t.title1;
      case SldsAvatarSize.size48:
        return t.heading2;
      case SldsAvatarSize.size56:
        return t.heading3;
    }
  }
}

class _AvatarColors {
  const _AvatarColors({
    required this.background,
    required this.foreground,
    required this.border,
  });

  final Color background;
  final Color foreground;
  final Color border;

  static _AvatarColors resolve(
      BuildContext context, SldsComponentState? state) {
    final c = context.slds.colors;
    final transparent = c.surfaceCard.withAlpha(
      context.slds.dimensions.transparentAlpha,
    );
    switch (state) {
      case SldsComponentState.disabled:
        return _AvatarColors(
          background: c.disabledBackground,
          foreground: c.disabledForeground,
          border: c.disabledBackground,
        );
      case SldsComponentState.error:
        return _AvatarColors(
          background: c.badgeErrorBackground,
          foreground: c.error,
          border: c.error,
        );
      case SldsComponentState.success:
        return _AvatarColors(
          background: c.badgeSuccessBackground,
          foreground: c.success,
          border: c.success,
        );
      case SldsComponentState.hover:
      case SldsComponentState.empty:
        return _AvatarColors(
          background: c.surfaceHover,
          foreground: c.textPrimary,
          border: c.borderDecorative,
        );
      case SldsComponentState.focus:
        return _AvatarColors(
          background: c.buttonPrimaryBackground,
          foreground: c.buttonPrimaryLabel,
          border: c.focusRing,
        );
      case SldsComponentState.active:
        return _AvatarColors(
          background: c.buttonPrimaryHover,
          foreground: c.buttonPrimaryLabel,
          border: c.buttonPrimaryHover,
        );
      case SldsComponentState.loading:
        return _AvatarColors(
          background: c.surfaceHover,
          foreground: c.textSecondary,
          border: c.borderDecorative,
        );
      case SldsComponentState.defaultState:
      case null:
        return _AvatarColors(
          background: c.buttonPrimaryBackground,
          foreground: c.buttonPrimaryLabel,
          border: transparent,
        );
    }
  }
}
