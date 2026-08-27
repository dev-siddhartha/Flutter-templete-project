import 'package:flutter/material.dart';

import '../styles/slds_list_style.dart';
import '../theme/slds_theme.dart';
import 'slds_badge.dart';
import 'slds_focus.dart';
import 'slds_state.dart';

/// Figma-backed SLDS list item.
class SldsListItem extends StatefulWidget {
  /// Creates an SLDS list item.
  const SldsListItem({
    super.key,
    required this.title,
    this.description,
    this.leading,
    this.badge,
    this.trailing,
    this.onTap,
    this.state,
    this.semanticLabel,
    this.width,
    this.emptyDescription,
    this.maxLines = 1,
    this.style,
  });

  final String title;

  final String? description;

  final Widget? leading;

  final SldsBadge? badge;

  final Widget? trailing;

  final VoidCallback? onTap;

  final SldsComponentState? state;

  final String? semanticLabel;

  /// When null, uses the token default (400 px).
  final double? width;

  /// Shown when [state] is [SldsComponentState.empty], instead of a
  /// hardcoded string, so callers can pass a localized value.
  final String? emptyDescription;

  /// Applies to both title and description.
  final int maxLines;

  /// Visual style overrides. Null fields inherit from the active [SldsTokenSet].
  final SldsListItemStyle? style;

  @override
  State<SldsListItem> createState() => _SldsListItemState();
}

class _SldsListItemState extends State<SldsListItem> {
  var _hovered = false;
  var _focused = false;
  var _pressed = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final s = widget.style;
    final state = widget.state ?? _interactiveState;
    final disabled = sldsStateIsDisabled(state) ||
        (widget.onTap == null && widget.state == null);
    final style = _ListItemStyle.resolve(
        context, disabled ? SldsComponentState.disabled : state);
    final description = state == SldsComponentState.empty
        ? (widget.emptyDescription ?? 'No details available')
        : widget.description;

    return Semantics(
      button: widget.onTap != null,
      enabled: !disabled,
      label: widget.semanticLabel ?? widget.title,
      child: FocusableActionDetector(
        enabled: !disabled,
        mouseCursor:
            !disabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onShowHoverHighlight: (value) => setState(() => _hovered = value),
        onShowFocusHighlight: (value) => setState(() => _focused = value),
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              if (!disabled) {
                widget.onTap?.call();
              }
              return null;
            },
          ),
        },
        child: GestureDetector(
          onTapDown: !disabled ? (_) => setState(() => _pressed = true) : null,
          onTapCancel:
              !disabled ? () => setState(() => _pressed = false) : null,
          onTapUp: !disabled ? (_) => setState(() => _pressed = false) : null,
          onTap: !disabled ? widget.onTap : null,
          child: AnimatedContainer(
            duration: tokens.motion.fast,
            width: widget.width ?? tokens.dimensions.listItemWidth,
            padding: s?.padding ??
                EdgeInsets.only(
                  left: tokens.dimensions.space16,
                  right: tokens.dimensions.space8,
                  top: tokens.dimensions.space8,
                  bottom: tokens.dimensions.space8,
                ),
            decoration: BoxDecoration(
              color: s?.backgroundColor ?? style.background,
              border: Border.all(color: style.border),
              boxShadow: state == SldsComponentState.focus
                  ? sldsFocusRing(tokens)
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      if (widget.leading != null)
                        SizedBox.square(
                          dimension: tokens.dimensions.listSlotSize,
                          child: Center(
                            child: IconTheme.merge(
                              data: IconThemeData(
                                color: style.foreground,
                                size: tokens.dimensions.avatarIconExtraLarge,
                              ),
                              child: widget.leading!,
                            ),
                          ),
                        ),
                      if (widget.leading != null)
                        SizedBox(width: tokens.dimensions.space12),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.title,
                              locale: Localizations.maybeLocaleOf(context),
                              style: (s?.titleStyle ?? tokens.typography.body1)
                                  .copyWith(
                                color: s?.titleStyle?.color ?? style.foreground,
                              ),
                              maxLines: widget.maxLines,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (description != null)
                              Text(
                                description,
                                locale: Localizations.maybeLocaleOf(context),
                                style: (s?.descriptionStyle ??
                                        tokens.typography.body2)
                                    .copyWith(
                                  color: s?.descriptionStyle?.color ??
                                      style.secondary,
                                ),
                                maxLines: widget.maxLines,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: tokens.dimensions.space8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state == SldsComponentState.loading)
                      SizedBox.square(
                        dimension: tokens.dimensions.iconSizeMedium,
                        child: CircularProgressIndicator(
                          strokeWidth: tokens.dimensions.progressStrokeWidth,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            style.foreground,
                          ),
                        ),
                      )
                    else if (widget.badge != null)
                      widget.badge!,
                    if (widget.trailing != null) ...[
                      SizedBox(width: tokens.dimensions.space8),
                      IconTheme.merge(
                        data: IconThemeData(
                          color: style.foreground,
                          size: tokens.dimensions.iconSizeMedium,
                        ),
                        child: widget.trailing!,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SldsComponentState get _interactiveState {
    if (_pressed) {
      return SldsComponentState.active;
    }
    if (_focused) {
      return SldsComponentState.focus;
    }
    if (_hovered) {
      return SldsComponentState.hover;
    }
    return SldsComponentState.defaultState;
  }
}

class _ListItemStyle {
  const _ListItemStyle({
    required this.background,
    required this.foreground,
    required this.secondary,
    required this.border,
  });

  final Color background;
  final Color foreground;
  final Color secondary;
  final Color border;

  static _ListItemStyle resolve(
      BuildContext context, SldsComponentState state) {
    final tokens = context.slds;
    final c = tokens.colors;
    final transparent =
        c.surfacePage.withAlpha(tokens.dimensions.transparentAlpha);
    switch (state) {
      case SldsComponentState.hover:
        return _ListItemStyle(
          background: c.surfaceHover,
          foreground: c.textPrimary,
          secondary: c.textSecondary,
          border: transparent,
        );
      case SldsComponentState.focus:
        return _ListItemStyle(
          background: c.surfacePage,
          foreground: c.textPrimary,
          secondary: c.textSecondary,
          border: c.focusRing,
        );
      case SldsComponentState.active:
        return _ListItemStyle(
          background: c.buttonPrimaryBackground,
          foreground: c.buttonPrimaryLabel,
          secondary: c.buttonPrimaryLabel,
          border: c.buttonPrimaryBackground,
        );
      case SldsComponentState.disabled:
        return _ListItemStyle(
          background: c.disabledBackground,
          foreground: c.disabledForeground,
          secondary: c.disabledForeground,
          border: c.disabledBackground,
        );
      case SldsComponentState.loading:
        return _ListItemStyle(
          background: c.badgePendingBackground,
          foreground: c.badgePendingText,
          secondary: c.badgePendingText,
          border: c.badgePendingText,
        );
      case SldsComponentState.error:
        return _ListItemStyle(
          background: c.badgeErrorBackground,
          foreground: c.error,
          secondary: c.error,
          border: c.error,
        );
      case SldsComponentState.empty:
        return _ListItemStyle(
          background: c.surfaceHover,
          foreground: c.textPrimary,
          secondary: c.textTertiary,
          border: c.borderDecorative,
        );
      case SldsComponentState.success:
        return _ListItemStyle(
          background: c.badgeSuccessBackground,
          foreground: c.success,
          secondary: c.success,
          border: c.success,
        );
      case SldsComponentState.defaultState:
        return _ListItemStyle(
          background: c.surfacePage,
          foreground: c.textPrimary,
          secondary: c.textSecondary,
          border: transparent,
        );
    }
  }
}
