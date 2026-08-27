import 'package:flutter/material.dart';

import '../styles/slds_pagination_style.dart';
import '../theme/slds_theme.dart';
import 'slds_focus.dart';
import 'slds_state.dart';

/// SLDS pagination control.
class SldsPagination extends StatelessWidget {
  /// Creates an SLDS pagination control.
  const SldsPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.onPageChanged,
    this.state,
    this.previousPageLabel,
    this.nextPageLabel,
    this.semanticLabel,
    this.style,
  });

  /// Current one-based page.
  final int currentPage;

  /// Total pages.
  final int totalPages;

  /// Page change callback.
  final ValueChanged<int>? onPageChanged;

  /// Optional forced visual state.
  final SldsComponentState? state;

  /// Accessible label for the previous-page button.
  /// Defaults to 'Previous page' when null — pass your app's localized string.
  final String? previousPageLabel;

  /// Accessible label for the next-page button.
  /// Defaults to 'Next page' when null — pass your app's localized string.
  final String? nextPageLabel;

  /// Accessible label for the pagination widget container.
  /// Defaults to 'Pagination' when null — pass your app's localized string.
  final String? semanticLabel;

  /// Visual style overrides. Null fields inherit from the active [SldsTokenSet].
  final SldsPaginationStyle? style;

  @override
  Widget build(BuildContext context) {
    final prevLabel = previousPageLabel ?? 'Previous page';
    final nextLabel = nextPageLabel ?? 'Next page';
    final safeTotal = totalPages <= 0 ? 1 : totalPages;
    final safeCurrent = currentPage.clamp(1, safeTotal).toInt();
    final disabled = onPageChanged == null ||
        sldsStateIsDisabled(
          state ?? SldsComponentState.defaultState,
        );
    final pages = _visiblePages(safeCurrent, safeTotal);

    return Semantics(
      container: true,
      label: semanticLabel ?? 'Pagination',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PageButton(
            icon: Icons.chevron_left,
            label: prevLabel,
            selected: false,
            disabled: disabled || safeCurrent == 1,
            state: state,
            style: style,
            onTap: () => onPageChanged?.call(safeCurrent - 1),
          ),
          for (final page in pages) ...[
            SizedBox(width: context.slds.dimensions.space4),
            _PageButton(
              label: '$page',
              selected: page == safeCurrent,
              disabled: disabled,
              state: state,
              style: style,
              onTap: () => onPageChanged?.call(page),
            ),
          ],
          SizedBox(width: context.slds.dimensions.space4),
          _PageButton(
            icon: Icons.chevron_right,
            label: nextLabel,
            selected: false,
            disabled: disabled || safeCurrent == safeTotal,
            state: state,
            style: style,
            onTap: () => onPageChanged?.call(safeCurrent + 1),
          ),
        ],
      ),
    );
  }

  List<int> _visiblePages(int current, int total) {
    if (total <= 5) {
      return [for (var page = 1; page <= total; page++) page];
    }
    final start =
        current <= 3 ? 1 : (current >= total - 2 ? total - 4 : current - 2);
    return [for (var page = start; page < start + 5; page++) page];
  }
}

class _PageButton extends StatelessWidget {
  const _PageButton({
    required this.label,
    required this.selected,
    required this.disabled,
    required this.state,
    required this.onTap,
    this.icon,
    this.style,
  });

  final String label;
  final IconData? icon;
  final bool selected;
  final bool disabled;
  final SldsComponentState? state;
  final VoidCallback onTap;
  final SldsPaginationStyle? style;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final pageStyle = _PageStyle.resolve(
      context,
      selected,
      disabled ? SldsComponentState.disabled : state,
    );
    final s = style;
    final effectiveBg = selected
        ? (s?.activeButtonColor ?? pageStyle.background)
        : (s?.inactiveButtonColor ?? pageStyle.background);
    final effectiveFg = selected
        ? (s?.activeTextColor ?? pageStyle.foreground)
        : (s?.inactiveTextColor ?? pageStyle.foreground);
    final effectiveSize = s?.buttonSize ?? tokens.dimensions.paginationItemSize;

    return Semantics(
      button: true,
      selected: selected,
      enabled: !disabled,
      label: label,
      child: GestureDetector(
        onTap: disabled ? null : onTap,
        child: Container(
          width: effectiveSize,
          height: effectiveSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: effectiveBg,
            borderRadius: BorderRadius.circular(tokens.dimensions.radiusXl),
            border: Border.all(color: pageStyle.border),
            boxShadow: !disabled && state == SldsComponentState.focus
                ? sldsFocusRing(tokens)
                : null,
          ),
          child: icon == null
              ? Text(
                  label,
                  style: (s?.labelStyle ?? tokens.typography.body1).copyWith(
                    color: effectiveFg,
                  ),
                )
              : Icon(icon,
                  size: tokens.dimensions.iconSizeMedium, color: effectiveFg),
        ),
      ),
    );
  }
}

class _PageStyle {
  const _PageStyle({
    required this.background,
    required this.foreground,
    required this.border,
  });

  final Color background;
  final Color foreground;
  final Color border;

  static _PageStyle resolve(
    BuildContext context,
    bool selected,
    SldsComponentState? state,
  ) {
    final c = context.slds.colors;
    switch (state) {
      case SldsComponentState.disabled:
        return _PageStyle(
          background: c.disabledBackground,
          foreground: c.disabledForeground,
          border: c.disabledBackground,
        );
      case SldsComponentState.error:
        return _PageStyle(
            background: c.badgeErrorBackground,
            foreground: c.error,
            border: c.error);
      case SldsComponentState.success:
        return _PageStyle(
            background: c.badgeSuccessBackground,
            foreground: c.success,
            border: c.success);
      case SldsComponentState.loading:
        return _PageStyle(
            background: c.badgePendingBackground,
            foreground: c.badgePendingText,
            border: c.badgePendingText);
      case SldsComponentState.focus:
        return _PageStyle(
            background: c.surfaceCard,
            foreground: c.textPrimary,
            border: c.focusRing);
      case SldsComponentState.hover:
      case SldsComponentState.empty:
        return _PageStyle(
            background: c.surfaceHover,
            foreground: c.textPrimary,
            border: c.borderDecorative);
      case SldsComponentState.active:
        return _PageStyle(
            background: c.buttonPrimaryBackground,
            foreground: c.buttonPrimaryLabel,
            border: c.buttonPrimaryBackground);
      case SldsComponentState.defaultState:
      case null:
        return _PageStyle(
          background: selected ? c.buttonPrimaryBackground : c.surfaceCard,
          foreground: selected ? c.buttonPrimaryLabel : c.textPrimary,
          border: selected ? c.buttonPrimaryBackground : c.borderDecorative,
        );
    }
  }
}
