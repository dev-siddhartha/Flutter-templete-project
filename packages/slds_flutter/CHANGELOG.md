# Changelog

All notable changes to `slds_flutter` follow semantic versioning.

## Unreleased

**Removed (breaking, alpha)**

- `SldsLocalizations`, `SldsLocalizationsEn`, `SldsLocalizationsDelegate`
  (`src/l10n/`) — this package no longer owns any localization system.
  `SldsSnackbar.dismissSemanticLabel`, `SldsPagination.previousPageLabel`
  / `nextPageLabel` / `semanticLabel` (new), `SldsDropdown.searchPlaceholder`
  / `noResultsLabel` (new), and `SldsStepper.valueLabel` (new) are now plain
  optional `String?` constructor parameters with English defaults — pass
  your app's own localized strings per call site instead of registering a
  delegate. See USAGE_GUIDE.md § "Localizations".
- `flutter_localizations` and `intl` dropped from `dependencies` (moved
  `flutter_localizations` to `dev_dependencies`, only used by the
  accessibility test harness now).

**Changed (breaking, alpha)**

- `SldsPalette`'s fields renamed to match the host app's own color naming
  (`primary`, `secondary`, `success`, `error`, `grey`, `warning`, `info`)
  instead of the prior SLDS Alpha taxonomy (`neutral`, `red`, `green`,
  `teal`, `blue`, `orange`, `purple`, `maroon`, `darkSubtle`); shades
  clamped to 50–900 (10 stops) to match. `SldsPalette.defaultPalette` is now
  ported 1:1 (name and value) from the host app's `AppColors`.

## 0.2.0-alpha.0 - 2026-07-13

Package-wide correctness and consistency audit. Alpha semver: breaking
changes below are not deprecated first (see Deprecation Policy — applies
from 0.2.0 onward).

**Fixed**

- `SldsInput`: box/border/background/focus-ring/icon-color styling was
  entirely inert (`SldsInputStyle` fields were declared but never read); the
  field is now a proper token-driven bordered container with live
  focus/hover tracking, matching `SldsTextArea`/`SldsDropdown`.
- `SldsRadio`: resting (unselected, non-hovered) state incorrectly rendered
  with the hover fill color.
- `SldsColorScheme.dark()`: `statusEscalated` mapped to the brand-gold
  palette instead of orange, inconsistent with every other theme.
- `SldsButton` / `SldsToggle`: replaced a `dimensions.controlBorderWidth`
  value used as a `Center` shrink-wrap factor with the literal `1.0` the
  layout trick actually requires — overriding that border-width token no
  longer corrupts button/toggle sizing.
- `SldsDropdown`: `SldsDropdownStyle.searchStyle` is now applied to the
  search field; the trigger now has proper `Semantics`.
- `SldsTabBar`: count badge now reads `SldsTabBarStyle.badgeBackgroundColor`
  / `badgeTextColor` instead of hardcoding a badge color, and includes
  `locale` on its `Text`.
- `SldsNavigationDrawer`: item width now derives from the actual outer
  padding instead of a hardcoded assumption; `activeItemLabelColor` /
  `inactiveItemLabelColor` are now applied; a selected item inside a
  disabled drawer no longer renders "active" styling.
- `SldsCard`: background now varies by state (error/success) consistent with
  border; tappable cards now expose `Semantics(button: true)`.
- `SldsListItem` / `SldsAccordion` / `SldsTabBar`: a read-only item (no
  `onTap`/`onChanged`) no longer silently forces `disabled` styling over an
  explicitly-passed `state`.
- `SldsAccordion`: removed an unintended `state == success` auto-expand
  side effect.
- `SldsPagination`: a disabled + force-`focus` page button no longer shows
  a focus ring.
- `SldsAvatar`: passing `image:` now renders the image even if `variant` was
  left at its default, instead of silently falling back to initials/icon.
- `SldsCheckbox`: indeterminate state is now exposed to assistive tech via
  `Semantics(checked: null, mixed: true)`.
- `SldsChip`: the delete (×) control is now keyboard-focusable and
  activatable via Enter/Space.
- `SldsSnackbar`: fixed a screen-reader double-announcement (title +
  description were read once via the live-region label and again via their
  child `Text` nodes); dismiss button tap target widened to the standard
  minimum.
- `SldsTooltip`: the `action` variant's close icon is now wired to an
  optional `onClose` callback instead of being permanently decorative.
- `SldsStepper`: semantic value now goes through `SldsLocalizations` instead
  of a hardcoded English "of".
- Hover state (`SldsComponentState.hover`) is now visually wired for
  `SldsCheckbox`, `SldsRadio`, and `SldsToggle` — previously a no-op.

**Added**

- `SldsText` + `SldsTextVariant`: a token-bound typography widget rendering
  any string via the active `SldsTokenSet.typography` scale.
- `SldsDialog.show()`: a convenience static wrapping the `showDialog` +
  `Dialog` boilerplate every call site previously hand-rolled.
- `SldsDialog.onDismiss` / `dismissSemanticLabel`: optional header close
  button, matching `SldsSnackbar`'s dismissal API shape.
- `operator==` / `hashCode` on `SldsColorScheme`, `SldsDimensionTokens`,
  `SldsTypographyTokens`, `SldsMotionTokens`, `SldsTokenSet`, and
  `SldsPalette`, so `SldsTheme.updateShouldNotify` no longer forces a full
  subtree rebuild on every value-equal token set reconstruction.
- `SldsLocalizations.stepperLabel(current, total)` for localizing
  `SldsStepper`'s semantic value.

**Removed (breaking, alpha)**

- Unused `SldsDimensionTokens` fields: `cardWidth`, `cardHeight`,
  `tabBadgeWidth`, `inputDisabledBorderWidth`, `dropdownMenuWidth` — dead,
  never read by any component.
- Deprecated `SldsColorTokens` typedef alias — use `SldsColorScheme`.
- `SldsCardStyle.titleStyle` / `descriptionStyle` — dead fields; `SldsCard`
  has no title/description slot (it takes a generic `child`).
- `tokens/slds_alpha.tokens.json` is no longer bundled as a Flutter asset in
  consuming apps (it was never loaded at runtime).

## 0.1.0-alpha.0 - 2026-07-02

- Added the initial Flutter package scaffold for SLDS Alpha.
- Added Figma-backed token source JSON and generated Dart token accessors.
- Added Tier 1 Alpha component APIs for Button, Input, Text Area, Checkbox, Radio, Toggle, Dropdown, Badge, Card, Dialog, and Snackbar.
- Added Tier 2 Alpha component APIs for Tab, Accordion, List, Pagination, Progress, Stepper, Avatar, Chip, Tag, Tooltip, and Navigation Drawer.
- Added accessibility, state-matrix, and visual regression test scaffolds.

## Deprecation Policy

- Patch releases may deprecate APIs but must not remove them.
- Minor releases may introduce replacements and migration guides.
- Major releases may remove APIs deprecated for at least one minor release.
- Every deprecation must include an owner, replacement API, migration example, and removal target.
