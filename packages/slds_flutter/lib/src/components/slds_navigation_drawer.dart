import 'package:flutter/material.dart';

import '../styles/slds_list_style.dart';
import '../styles/slds_navigation_drawer_style.dart';
import '../theme/slds_theme.dart';
import 'slds_list.dart';
import 'slds_state.dart';

/// Navigation drawer item.
class SldsNavigationDrawerItem {
  /// Creates a navigation drawer item.
  const SldsNavigationDrawerItem({
    required this.label,
    this.description,
    this.icon,
    this.selected = false,
    this.onTap,
  });

  /// Label.
  final String label;

  /// Optional description.
  final String? description;

  /// Optional icon.
  final IconData? icon;

  /// Whether the item is selected.
  final bool selected;

  /// Tap callback.
  final VoidCallback? onTap;
}

/// SLDS navigation drawer inferred from the Navigation and List Figma patterns.
class SldsNavigationDrawer extends StatelessWidget {
  /// Creates an SLDS navigation drawer.
  const SldsNavigationDrawer({
    super.key,
    required this.title,
    required this.items,
    this.footer,
    this.state,
    this.width,
    this.style,
  });

  /// Drawer title.
  final String title;

  /// Drawer items.
  final List<SldsNavigationDrawerItem> items;

  /// Optional footer widget pinned at the bottom.
  final Widget? footer;

  /// Optional forced visual state.
  final SldsComponentState? state;

  /// Optional fixed width. When null uses the token default (320 px).
  final double? width;

  /// Visual style overrides. Null fields inherit from the active [SldsTokenSet].
  final SldsNavigationDrawerStyle? style;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final drawerWidth = width ?? tokens.dimensions.navigationDrawerWidth;
    final disabled =
        sldsStateIsDisabled(state ?? SldsComponentState.defaultState);
    final s = style;
    final outerPadding =
        s?.itemPadding ?? EdgeInsets.all(tokens.dimensions.space16);
    final itemWidth = drawerWidth -
        outerPadding.resolve(Directionality.of(context)).horizontal;
    return Semantics(
      container: true,
      label: title,
      child: Container(
        width: drawerWidth,
        padding: outerPadding,
        decoration: BoxDecoration(
          color: s?.backgroundColor ?? tokens.colors.surfaceCard,
          border: Border(
            right: BorderSide(color: tokens.colors.borderDecorative),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              locale: Localizations.maybeLocaleOf(context),
              style: (s?.titleStyle ?? tokens.typography.title1).copyWith(
                color: disabled
                    ? tokens.colors.disabledForeground
                    : tokens.colors.textPrimary,
              ),
            ),
            SizedBox(height: tokens.dimensions.space16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final item in items) ...[
                      SldsListItem(
                        title: item.label,
                        description: item.description,
                        leading: item.icon == null ? null : Icon(item.icon),
                        trailing:
                            item.selected ? const Icon(Icons.check) : null,
                        onTap: disabled ? null : item.onTap,
                        width: itemWidth,
                        state: disabled
                            ? SldsComponentState.disabled
                            : item.selected
                                ? SldsComponentState.active
                                : state ?? SldsComponentState.defaultState,
                        style: s == null
                            ? null
                            : SldsListItemStyle(
                                backgroundColor: item.selected
                                    ? s.activeItemBackgroundColor
                                    : s.inactiveItemBackgroundColor,
                                titleStyle: _itemLabelStyle(s, item.selected),
                              ),
                      ),
                      SizedBox(height: tokens.dimensions.space4),
                    ],
                  ],
                ),
              ),
            ),
            if (footer != null) footer!,
          ],
        ),
      ),
    );
  }

  TextStyle? _itemLabelStyle(SldsNavigationDrawerStyle s, bool selected) {
    final color = selected ? s.activeItemLabelColor : s.inactiveItemLabelColor;
    if (color == null) return s.itemStyle;
    return (s.itemStyle ?? const TextStyle()).copyWith(color: color);
  }
}
