import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/slds_accordion_style.dart';
import '../theme/slds_theme.dart';
import 'slds_state.dart';

/// Figma-backed SLDS accordion.
class SldsAccordion extends StatefulWidget {
  /// Creates an SLDS accordion.
  const SldsAccordion({
    super.key,
    required this.title,
    required this.child,
    this.width,
    this.style,
    this.state,
    this.initialExpansion = false,
  });

  /// Header title.
  final String title;

  /// Expanded content.
  final Widget child;

  /// Optional fixed width.
  final double? width;

  /// Optional stylings
  final SldsAccordionStyle? style;

  /// Optional state
  final SldsComponentState? state;

  /// initially expanded
  final bool initialExpansion;

  @override
  State<SldsAccordion> createState() => _SldsAccordionState();
}

class _SldsAccordionState extends State<SldsAccordion> {
  late final ExpansibleController _controller;
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _controller = ExpansibleController();
    _isExpanded = widget.initialExpansion;
  }

  @override
  void didUpdateWidget(SldsAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialExpansion != widget.initialExpansion &&
        widget.initialExpansion != _isExpanded) {
      // Actually drives the ExpansionTile's real state, not a shadow copy.
      if (widget.initialExpansion) {
        _controller.expand();
      } else {
        _controller.collapse();
      }
    }
  }

  void _handleExpansionChanged(bool expanded) {
    setState(() => _isExpanded = expanded);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final style = _AccordionStyle.resolve(
      context,
      widget.state ?? SldsComponentState.defaultState,
    );

    return AnimatedContainer(
      duration: tokens.motion.normal,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.style?.headerBackgroundColor ?? style.background,
        borderRadius: BorderRadius.circular(
            widget.style?.borderRadius ?? tokens.dimensions.radius2xl),
        boxShadow: [
          BoxShadow(
            color: tokens.colors.textPrimary.withAlpha(20),
            blurRadius: 16.r,
            offset: const Offset(0, 4),
            spreadRadius: 0.r,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          widget.style?.borderRadius ?? tokens.dimensions.radius2xl,
        ),
        child: ExpansionTile(
          controller: _controller,
          // Semantics scoped to header only — ExpansionTile's internal
          // ListTile already emits button+onTap semantics for the header,
          // and its expand/collapse state announcement is handled by the
          // framework. No manual Semantics wrapper needed. Verify with
          // accessibility inspector (see "What to Measure").
          title: Text(
            widget.title,
            style: (widget.style?.titleStyle ?? tokens.typography.body1)
                .copyWith(color: style.foreground),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          tilePadding: EdgeInsets.symmetric(
              horizontal: tokens.dimensions.space12,
              vertical: tokens.dimensions.space4),
          initiallyExpanded: widget.initialExpansion,
          trailing: Icon(
            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: style.foreground,
          ),
          onExpansionChanged: _handleExpansionChanged,
          dense: true,
          shape: const Border.fromBorderSide(BorderSide.none),
          collapsedShape: const Border.fromBorderSide(BorderSide.none),
          iconColor: style.foreground,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: tokens.dimensions.space12),
              child: Container(
                padding: widget.style?.contentPadding ??
                    EdgeInsets.all(tokens.dimensions.space8),
                decoration: BoxDecoration(
                  color: widget.style?.contentBackgroundColor ??
                      style.contentBackground,
                  borderRadius: BorderRadius.circular(
                      widget.style?.borderRadius ?? tokens.dimensions.radiusXl),
                ),
                child: DefaultTextStyle.merge(
                  style:
                      tokens.typography.body1.copyWith(color: style.secondary),
                  child: widget.child,
                ),
              ),
            ),
            SizedBox(height: tokens.dimensions.space12),
          ],
        ),
      ),
    );
  }
}

class _AccordionStyle {
  const _AccordionStyle({
    required this.background,
    required this.contentBackground,
    required this.foreground,
    required this.secondary,
    required this.border,
  });

  final Color background;
  final Color contentBackground;
  final Color foreground;
  final Color secondary;
  final Color border;

  static _AccordionStyle resolve(
      BuildContext context, SldsComponentState state) {
    final tokens = context.slds;
    final c = tokens.colors;
    final transparent =
        c.surfacePage.withAlpha(tokens.dimensions.transparentAlpha);
    switch (state) {
      case SldsComponentState.disabled:
        return _AccordionStyle(
          background: c.disabledBackground,
          contentBackground: c.disabledBackground,
          foreground: c.disabledForeground,
          secondary: c.disabledForeground,
          border: c.disabledBackground,
        );
      case SldsComponentState.error:
        return _AccordionStyle(
          background: c.badgeErrorBackground,
          contentBackground: c.surfaceHover,
          foreground: c.error,
          secondary: c.error,
          border: c.error,
        );
      case SldsComponentState.success:
        return _AccordionStyle(
          background: c.badgeSuccessBackground,
          contentBackground: c.surfaceHover,
          foreground: c.success,
          secondary: c.textSecondary,
          border: c.success,
        );
      case SldsComponentState.focus:
        return _AccordionStyle(
          background: c.surfacePage,
          contentBackground: c.surfaceHover,
          foreground: c.textPrimary,
          secondary: c.textSecondary,
          border: c.focusRing,
        );
      case SldsComponentState.hover:
      case SldsComponentState.empty:
        return _AccordionStyle(
          background: c.surfaceHover,
          contentBackground: c.surfaceCard,
          foreground: c.textPrimary,
          secondary: c.textSecondary,
          border: c.borderDecorative,
        );
      case SldsComponentState.active:
        return _AccordionStyle(
          background: c.buttonPrimaryBackground,
          contentBackground: c.surfaceHover,
          foreground: c.buttonPrimaryLabel,
          secondary: c.textSecondary,
          border: c.buttonPrimaryBackground,
        );
      case SldsComponentState.loading:
        return _AccordionStyle(
          background: c.badgePendingBackground,
          contentBackground: c.surfaceHover,
          foreground: c.badgePendingText,
          secondary: c.badgePendingText,
          border: c.badgePendingText,
        );
      case SldsComponentState.defaultState:
        return _AccordionStyle(
          background: c.surfacePage,
          contentBackground: c.surfaceHover,
          foreground: c.textPrimary,
          secondary: c.textSecondary,
          border: transparent,
        );
    }
  }
}
