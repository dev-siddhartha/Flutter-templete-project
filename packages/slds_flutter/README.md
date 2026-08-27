# SLDS Flutter

`slds_flutter` is the Flutter package for the SLDS Alpha design system. The authoritative Alpha specification is the `SLDS_Alpha v0.1` Figma design system file, supported by the shared token source in `tokens/slds_alpha.tokens.json`.

## Tier 1 Components

- Button
- Input
- Text Area
- Checkbox
- Radio
- Toggle
- Dropdown
- Badge
- Card
- Dialog
- Snackbar

## Tier 2 Components

- Tab
- Accordion
- List
- Pagination
- Progress
- Stepper
- Avatar
- Chip
- Tag
- Tooltip
- Navigation Drawer

## Typography

`SldsText` renders any string using the active `SldsTokenSet`'s typography
scale (`SldsTextVariant.body1`, `.heading2`, `.caption1`, etc.) instead of a
hand-rolled `TextStyle`, so text automatically follows theme, palette, and
per-app typography overrides. See
[USAGE_GUIDE.md](USAGE_GUIDE.md#sldstext).

## Token Source

`lib/src/tokens/slds_tokens.dart` and `lib/src/tokens/slds_palette.dart` are the single authoritative, live token source consumed by every component. `tokens/slds_alpha.tokens.json` is a point-in-time design reference exported from Figma — it is **not** loaded at runtime, there is no codegen step (`tool/generate_tokens.dart` only validates the file, it does not generate code), and it is **not** kept in sync automatically. Treat values in the JSON as historical reference only; when in doubt, `slds_tokens.dart` wins.

## Modes

The package exposes token modes for:

- Light
- Dark
- High Contrast
- Reduced Motion

## Locale Coverage

This package ships no localization system of its own — it's a generic,
reusable component library and shouldn't own app-specific copy or locale
decisions. A handful of components accept small built-in accessibility/UI
strings (dismiss label, search placeholder, pagination labels, etc.) as plain
optional constructor parameters with English defaults; pass your own
localized strings (e.g. from your app's `AppLocalizations`) at each call site
to translate them. See [USAGE_GUIDE.md](USAGE_GUIDE.md#localizations) for the
full list of overridable strings per component.

The example app (`example/`) still demonstrates English, Sinhala, and Tamil
content, but does so entirely through its own `_Copy` class — not through
anything in this package.

## Verification Status

Current verification baseline: Flutter 3.44.4.

- `flutter analyze`
- `flutter test`
