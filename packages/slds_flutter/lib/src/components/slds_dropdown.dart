import 'package:flutter/material.dart';

import '../styles/slds_dropdown_style.dart';
import '../styles/slds_input_style.dart';
import '../theme/slds_theme.dart';
import 'package:slds_flutter/src/tokens/slds_tokens.dart';
import 'slds_focus.dart';
import 'slds_input.dart';
import 'slds_state.dart';

/// Item model for [SldsDropdown].
class SldsDropdownItem<T> {
  /// Creates a dropdown item.
  const SldsDropdownItem({required this.value, required this.label});

  final T value;

  final String label;
}

/// Trigger and item visuals are token-driven; the open menu renders in the
/// app [Overlay] via [MenuAnchor], giving viewport-aware positioning,
/// dismiss-on-outside-tap, Escape to close, and arrow-key/tab traversal for free.
class SldsDropdown<T> extends StatefulWidget {
  /// Creates an SLDS dropdown.
  const SldsDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.placeholder,
    this.showSearch = false,
    this.searchPlaceholder,
    this.noResultsLabel,
    this.helperText,
    this.required = false,
    this.state,
    this.width,
    this.style,
    this.onOpen,
    this.onClose,
  });

  final String label;

  final List<SldsDropdownItem<T>> items;

  final T? value;

  final ValueChanged<T?>? onChanged;

  /// Shown when no value is selected.
  final String? placeholder;

  /// Shows a search field in the open menu. Defaults to false.
  final bool showSearch;

  /// Defaults to 'Search' when null — pass your app's localized string.
  final String? searchPlaceholder;

  /// Shown when [showSearch] filters out every item.
  /// Defaults to 'No results' when null — pass your app's localized string.
  final String? noResultsLabel;

  final String? helperText;

  /// Whether the field is required.
  final bool required;

  /// Optional forced state.
  final SldsComponentState? state;

  /// Optional fixed width. When null the field fills its parent.
  final double? width;

  /// Visual style overrides. Null fields inherit from the active [SldsTokenSet].
  final SldsDropdownStyle? style;

  /// Called when the menu opens.
  final VoidCallback? onOpen;

  /// Called when the menu closes, whether by selection, outside tap, or Escape.
  final VoidCallback? onClose;

  @override
  State<SldsDropdown<T>> createState() => _SldsDropdownState<T>();
}

class _SldsDropdownState<T> extends State<SldsDropdown<T>> {
  final _menuController = MenuController();
  final _searchController = TextEditingController();
  final _triggerKey = GlobalKey();
  var _open = false;
  var _focused = false;
  var _query = '';
  // Set from the trigger's actual rendered size right before the menu opens —
  // the source of truth for menu width, not widget.width or any prediction.
  double? _measuredWidth;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<SldsDropdownItem<T>> get _filteredItems {
    if (_query.isEmpty) return widget.items;
    final lower = _query.toLowerCase();
    return widget.items
        .where((item) => item.label.toLowerCase().contains(lower))
        .toList();
  }

  void _handleMenuOpen() {
    setState(() => _open = true);
    widget.onOpen?.call();
  }

  void _handleMenuClose() {
    setState(() {
      _open = false;
      _query = '';
    });
    _searchController.clear();
    widget.onClose?.call();
  }

  void _handleItemSelected(SldsDropdownItem<T> item) {
    widget.onChanged?.call(item.value);
    _menuController.close();
  }

  /// Measures the trigger's rendered width before opening, so the menu
  /// never flashes at a stale/default width for a frame.
  void _toggleMenu() {
    if (_menuController.isOpen) {
      _menuController.close();
      return;
    }
    final renderBox =
        _triggerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      _measuredWidth = renderBox.size.width;
    }
    _menuController.open();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final colors = tokens.colors;
    final dimensions = tokens.dimensions;
    final s = widget.style;
    final selected = _selectedLabel();
    final state = widget.state ??
        (_focused
            ? SldsComponentState.focus
            : _open
                ? SldsComponentState.active
                : SldsComponentState.defaultState);
    final enabled = widget.onChanged != null && !sldsStateIsDisabled(state);
    final isFocused =
        state == SldsComponentState.focus || state == SldsComponentState.active;
    final borderColor = !enabled
        ? colors.inputBorderDisabled
        : state == SldsComponentState.error
            ? colors.error
            : state == SldsComponentState.success
                ? colors.success
                : isFocused
                    ? (s?.focusBorderColor ?? colors.inputBorderFocused)
                    : (s?.borderColor ?? colors.inputBorderDefault);
    final background = s?.backgroundColor ??
        (state == SldsComponentState.hover
            ? colors.surfaceHover
            : colors.surfacePage);
    // Fallback for before any measurement happens; _toggleMenu always
    // measures first, so this is just a non-null safety net.
    final menuWidth = _measuredWidth ?? widget.width ?? dimensions.inputWidth;

    // Explicit width wraps and constrains; null width relies on the
    // stretch below to fill the parent's available space.
    return widget.width != null
        ? SizedBox(
            width: widget.width,
            child: _buildContent(context, tokens, enabled, colors, dimensions,
                s, menuWidth, selected, background, borderColor, state),
          )
        : _buildContent(context, tokens, enabled, colors, dimensions, s,
            menuWidth, selected, background, borderColor, state);
  }

  Column _buildContent(
      BuildContext context,
      SldsTokenSet tokens,
      bool enabled,
      SldsColorScheme colors,
      SldsDimensionTokens dimensions,
      SldsDropdownStyle? s,
      double menuWidth,
      String? selected,
      Color background,
      Color borderColor,
      SldsComponentState state) {
    return Column(
      // stretch: fills the parent's maxWidth constraint when width is null.
      crossAxisAlignment: widget.width == null
          ? CrossAxisAlignment.stretch
          : CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                widget.label,
                locale: Localizations.maybeLocaleOf(context),
                style: tokens.typography.body1.copyWith(
                  color:
                      enabled ? colors.inputLabel : colors.disabledForeground,
                ),
              ),
            ),
            if (widget.required)
              Text(
                '*',
                style: tokens.typography.body1.copyWith(color: colors.error),
              ),
          ],
        ),
        SizedBox(height: dimensions.space4),
        MenuAnchor(
          controller: _menuController,
          consumeOutsideTap: true,
          alignmentOffset: Offset(0, dimensions.space6),
          onOpen: _handleMenuOpen,
          onClose: _handleMenuClose,
          style: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(
              s?.menuBackgroundColor ?? colors.surfacePage,
            ),
            surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
            elevation: WidgetStatePropertyAll(dimensions.elevationBlur),
            shadowColor: WidgetStatePropertyAll(colors.textPrimary),
            side: WidgetStatePropertyAll(
              BorderSide(color: s?.menuBorderColor ?? colors.borderDecorative),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(dimensions.radius3xl),
              ),
            ),
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          ),
          menuChildren: [
            // menuWidth is the measured value, matching the trigger's real
            // rendered width regardless of how it got that width.
            SizedBox(
              width: menuWidth,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: dimensions.space8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.showSearch) ...[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: dimensions.space8),
                        child: SldsInput(
                          controller: _searchController,
                          onChanged: (value) => setState(() => _query = value),
                          placeholder:
                              widget.searchPlaceholder ?? 'Search',
                          style: s?.searchStyle == null
                              ? null
                              : SldsInputStyle(inputStyle: s!.searchStyle),
                          leading: Icon(
                            Icons.search,
                            size: dimensions.iconSizeMedium,
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                      SizedBox(height: dimensions.space4),
                    ],
                    for (final item in _filteredItems)
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: dimensions.space8),
                        child: MenuItemButton(
                          style: ButtonStyle(
                            padding:
                                const WidgetStatePropertyAll(EdgeInsets.zero),
                            backgroundColor: const WidgetStatePropertyAll(
                                Colors.transparent),
                            overlayColor:
                                WidgetStatePropertyAll(colors.surfaceHover),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(dimensions.radiusXl),
                              ),
                            ),
                          ),
                          onPressed:
                              enabled ? () => _handleItemSelected(item) : null,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: dimensions.space12,
                              vertical: dimensions.space8,
                            ),
                            decoration: BoxDecoration(
                              color: item.value == widget.value
                                  ? colors.surfaceHover
                                  : Colors.transparent,
                              borderRadius:
                                  BorderRadius.circular(dimensions.radiusXl),
                            ),
                            child: Text(
                              item.label,
                              locale: Localizations.maybeLocaleOf(context),
                              style: (s?.itemStyle ?? tokens.typography.body2)
                                  .copyWith(color: colors.textPrimary),
                            ),
                          ),
                        ),
                      ),
                    if (_filteredItems.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: dimensions.space20,
                          vertical: dimensions.space12,
                        ),
                        child: Text(
                          widget.noResultsLabel ?? 'No results',
                          style: tokens.typography.body2
                              .copyWith(color: colors.textSecondary),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
          builder: (context, controller, child) {
            return Semantics(
              button: true,
              enabled: enabled,
              label: widget.label,
              value: selected ?? widget.placeholder,
              child: FocusableActionDetector(
                enabled: enabled,
                includeFocusSemantics: false,
                onShowFocusHighlight: (value) =>
                    setState(() => _focused = value),
                actions: {
                  ActivateIntent: CallbackAction<ActivateIntent>(
                    onInvoke: (_) {
                      if (enabled) _toggleMenu();
                      return null;
                    },
                  ),
                },
                child: GestureDetector(
                  onTap: enabled ? _toggleMenu : null,
                  child: AnimatedContainer(
                    key: _triggerKey, // <-- measured for menu width
                    duration: tokens.motion.fast,
                    height: dimensions.inputHeight,
                    padding: s?.contentPadding ??
                        EdgeInsets.symmetric(horizontal: dimensions.space8),
                    decoration: BoxDecoration(
                      color: background,
                      border: Border.all(color: borderColor),
                      borderRadius: BorderRadius.circular(
                          s?.borderRadius ?? dimensions.radius2xl),
                      boxShadow: state == SldsComponentState.focus
                          ? sldsFocusRing(tokens)
                          : null,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: dimensions.space8),
                            child: Text(
                              selected ?? widget.placeholder ?? '',
                              locale: Localizations.maybeLocaleOf(context),
                              style: selected == null
                                  ? (s?.hintStyle ?? tokens.typography.body1)
                                      .copyWith(color: colors.inputPlaceholder)
                                  : (s?.selectedItemStyle ??
                                          tokens.typography.body1)
                                      .copyWith(color: colors.textPrimary),
                            ),
                          ),
                        ),
                        SizedBox.square(
                          dimension: dimensions.iconButtonMedium,
                          child: Center(
                            child: Icon(
                              _open
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: colors.textPrimary,
                              size: dimensions.iconSizeMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        if (widget.helperText != null) ...[
          SizedBox(height: dimensions.space6),
          Text(
            widget.helperText!,
            locale: Localizations.maybeLocaleOf(context),
            style:
                tokens.typography.caption1.copyWith(color: colors.inputHelper),
          ),
        ],
      ],
    );
  }

  String? _selectedLabel() {
    for (final item in widget.items) {
      if (item.value == widget.value) return item.label;
    }
    return null;
  }
}
