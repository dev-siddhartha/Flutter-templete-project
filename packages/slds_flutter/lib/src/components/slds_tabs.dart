import 'package:flutter/material.dart';

import '../styles/slds_tabs_style.dart';
import '../theme/slds_theme.dart';
import '../tokens/slds_tokens.dart';
import 'slds_focus.dart';
import 'slds_state.dart';

/// Tab item data for [SldsTabBar].
class SldsTabItem {
  /// Creates a tab item.
  const SldsTabItem({
    required this.label,
    this.leading,
    this.trailing,
    this.badgeCount,
    this.semanticLabel,
  });

  /// Tab label.
  final String label;

  /// Optional leading widget.
  final Widget? leading;

  /// Optional trailing widget.
  final Widget? trailing;

  /// Optional count badge.
  final int? badgeCount;

  /// Screen reader label.
  final String? semanticLabel;
}

/// Figma-backed SLDS tab strip.
class SldsTabBar extends StatelessWidget {
  /// Creates an SLDS tab bar.
  const SldsTabBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onChanged,
    this.state,
    this.width,
    this.style,
  });

  /// Tab items.
  final List<SldsTabItem> items;

  /// Selected item index.
  final int selectedIndex;

  /// Selection callback.
  final ValueChanged<int>? onChanged;

  /// Optional forced visual state.
  final SldsComponentState? state;

  /// Optional fixed width. When null uses the token default (451 px).
  final double? width;

  /// Visual style overrides. Null fields inherit from the active [SldsTokenSet].
  final SldsTabBarStyle? style;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    return Semantics(
      container: true,
      child: Container(
        width: width ?? tokens.dimensions.tabStripWidth,
        padding: EdgeInsets.all(tokens.dimensions.space4),
        decoration: BoxDecoration(
          color: style?.backgroundColor ?? tokens.colors.surfaceHover,
          borderRadius: BorderRadius.circular(tokens.dimensions.radius3xl),
          boxShadow:
              state == SldsComponentState.focus ? sldsFocusRing(tokens) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var index = 0; index < items.length; index++) ...[
              if (index > 0) SizedBox(width: tokens.dimensions.space8),
              Flexible(
                child: _SldsTabButton(
                  item: items[index],
                  selected: selectedIndex == index,
                  state: state,
                  onTap: onChanged == null ? null : () => onChanged!(index),
                  style: style,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SldsTabButton extends StatefulWidget {
  const _SldsTabButton({
    required this.item,
    required this.selected,
    required this.state,
    required this.onTap,
    this.style,
  });

  final SldsTabItem item;
  final bool selected;
  final SldsComponentState? state;
  final VoidCallback? onTap;
  final SldsTabBarStyle? style;

  @override
  State<_SldsTabButton> createState() => _SldsTabButtonState();
}

class _SldsTabButtonState extends State<_SldsTabButton> {
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
    final style = _TabStyle.resolve(
      context,
      widget.selected,
      disabled ? SldsComponentState.disabled : state,
    );

    return Semantics(
      button: true,
      selected: widget.selected,
      enabled: !disabled,
      label: widget.item.semanticLabel ?? widget.item.label,
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
            padding: EdgeInsets.symmetric(
              horizontal: tokens.dimensions.space12,
              vertical: tokens.dimensions.space4,
            ),
            decoration: BoxDecoration(
              color: style.background,
              borderRadius: BorderRadius.circular(tokens.dimensions.radius2xl),
              border: Border.all(color: s?.indicatorColor ?? style.border),
              boxShadow: widget.selected ? _tabShadow(tokens) : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.item.leading != null)
                  IconTheme.merge(
                    data: IconThemeData(
                      color: widget.selected
                          ? (s?.activeTabColor ?? style.foreground)
                          : (s?.inactiveTabColor ?? style.foreground),
                      size: tokens.dimensions.iconSizeMedium,
                    ),
                    child: widget.item.leading!,
                  ),
                if (widget.item.leading != null)
                  SizedBox(width: tokens.dimensions.space4),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(tokens.dimensions.space4),
                    child: Text(
                      widget.item.label,
                      locale: Localizations.maybeLocaleOf(context),
                      style:
                          (s?.labelStyle ?? tokens.typography.body2).copyWith(
                        color: widget.selected
                            ? (s?.activeTabColor ?? style.foreground)
                            : (s?.inactiveTabColor ?? style.foreground),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                if (widget.item.badgeCount != null) ...[
                  SizedBox(width: tokens.dimensions.space4),
                  Container(
                    constraints: BoxConstraints(
                      minWidth: tokens.dimensions.tabBadgeMinWidth,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: tokens.dimensions.space8,
                      vertical: tokens.dimensions.space1,
                    ),
                    decoration: BoxDecoration(
                      color: s?.badgeBackgroundColor ??
                          context.slds.colors.badgeInReviewBackground,
                      borderRadius: BorderRadius.circular(
                        tokens.dimensions.radiusFull,
                      ),
                    ),
                    child: Text(
                      '${widget.item.badgeCount}',
                      locale: Localizations.maybeLocaleOf(context),
                      style: tokens.typography.caption1.copyWith(
                        color: s?.badgeTextColor ??
                            context.slds.colors.badgeInReviewText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                if (widget.item.trailing != null)
                  SizedBox(width: tokens.dimensions.space4),
                if (widget.item.trailing != null)
                  IconTheme.merge(
                    data: IconThemeData(
                      color: widget.selected
                          ? (s?.activeTabColor ?? style.foreground)
                          : (s?.inactiveTabColor ?? style.foreground),
                      size: tokens.dimensions.iconSizeMedium,
                    ),
                    child: widget.item.trailing!,
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

  List<BoxShadow> _tabShadow(SldsTokenSet tokens) {
    return [
      BoxShadow(
        color:
            tokens.colors.textPrimary.withAlpha(tokens.dimensions.raisedAlpha),
        blurRadius: tokens.dimensions.space2,
        offset: Offset(tokens.dimensions.space0, tokens.dimensions.space1),
      ),
    ];
  }
}

class _TabStyle {
  const _TabStyle({
    required this.background,
    required this.foreground,
    required this.border,
  });

  final Color background;
  final Color foreground;
  final Color border;

  static _TabStyle resolve(
    BuildContext context,
    bool selected,
    SldsComponentState state,
  ) {
    final tokens = context.slds;
    final c = tokens.colors;
    final transparent =
        c.surfacePage.withAlpha(tokens.dimensions.transparentAlpha);
    switch (state) {
      case SldsComponentState.disabled:
        return _TabStyle(
          background: c.disabledBackground,
          foreground: c.disabledForeground,
          border: c.disabledBackground,
        );
      case SldsComponentState.error:
        return _TabStyle(
            background: c.badgeErrorBackground,
            foreground: c.error,
            border: c.error);
      case SldsComponentState.success:
        return _TabStyle(
            background: c.surfacePage,
            foreground: c.success,
            border: c.success);
      case SldsComponentState.focus:
        return _TabStyle(
            background: c.surfacePage,
            foreground: c.textPrimary,
            border: c.focusRing);
      case SldsComponentState.hover:
        return _TabStyle(
            background: c.surfaceCard,
            foreground: c.textPrimary,
            border: c.borderDecorative);
      case SldsComponentState.active:
        return _TabStyle(
            background: c.buttonPrimaryBackground,
            foreground: c.buttonPrimaryLabel,
            border: c.buttonPrimaryBackground);
      case SldsComponentState.loading:
        return _TabStyle(
            background: c.badgePendingBackground,
            foreground: c.badgePendingText,
            border: c.badgePendingText);
      case SldsComponentState.empty:
        return _TabStyle(
            background: c.surfaceHover,
            foreground: c.textTertiary,
            border: c.borderDecorative);
      case SldsComponentState.defaultState:
        return _TabStyle(
          background: selected ? c.surfacePage : transparent,
          foreground: selected ? c.textPrimary : c.textSecondary,
          border: transparent,
        );
    }
  }
}
