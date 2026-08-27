# Design System (SLDS Flutter)

This project's UI is built on `slds_flutter`, a local package at `packages/slds_flutter` (imported as `path: packages/slds_flutter` in `pubspec.yaml`, package name `slds_flutter`). It implements the **SLDS Alpha** design system: theme tokens, typography, and a set of ready-made components. **Always build screens with SLDS components/tokens instead of raw Material widgets or hand-picked colors/text styles**, so the app stays consistent and themeable.

Full component API and every option lives in `packages/slds_flutter/USAGE_GUIDE.md` — this doc covers what it is, how it's wired into *this* app, and the everyday usage patterns. When you need a detail not covered here (a component not listed below, a less common parameter, form validation patterns, accessibility notes), read `USAGE_GUIDE.md` directly rather than guessing.

## What it is

- **Tokens** (`packages/slds_flutter/lib/src/tokens/`) — the single source of truth for colors, typography, dimensions, and motion. `slds_tokens.dart` / `slds_palette.dart` are the live, authoritative values; `tokens/slds_alpha.tokens.json` (a Figma export) is historical reference only — it is **not** loaded at runtime and is **not** kept in sync automatically.
- **Theme** (`SldsTheme`, `SldsTokenSet`) — a widget that provides an `SldsTokenSet` (colors + typography + dimensions + motion) down the tree, with `light()`, `dark()`, `highContrast()` factories, and a `reducedMotion` flag.
- **Palette** (`SldsPalette`) — a 3-layer color system. `SldsPalette` holds raw color swatches (`primary`, `secondary`, `success`, `error`, `grey`, `warning`, `info`), each a 50–900 shade map (`palette.primary[500]`, etc) — named to match this project's own `AppColors`. Semantic tokens (e.g. `buttonPrimaryBackground`) reference palette shades, so changing one shade propagates everywhere that token is used, across all modes.
- **Components** (`packages/slds_flutter/lib/src/components/`) — `SldsButton`, `SldsInput`, `SldsTextArea`, `SldsDropdown`, `SldsCheckbox`, `SldsRadio`, `SldsToggle`, `SldsBadge`, `SldsCard`, `SldsDialog`, `SldsSnackbar` (Tier 1); `SldsTabBar`, `SldsAccordion`, `SldsListItem`, `SldsPagination`, `SldsProgress`, `SldsStepper`, `SldsAvatar`, `SldsChip`, `SldsTag`, `SldsTooltip`, `SldsNavigationDrawer` (Tier 2); plus `SldsText` for typography.
- **Modes** — Light, Dark, High Contrast, Reduced Motion.
- **Localizations** — the package owns no localization system. A handful of components (`SldsSnackbar`, `SldsPagination`, `SldsDropdown`, `SldsStepper`) take a few UI strings as plain optional constructor parameters with English defaults (e.g. `dismissSemanticLabel`, `previousPageLabel`) — pass this app's own `AppLocalizations` strings at each call site to translate them. See `packages/slds_flutter/USAGE_GUIDE.md` § "Localizations" for the full list.

## How it's wired into this app

Don't call `SldsTokenSet.light()/dark()/highContrast()` directly in app code — go through this project's wrapper so the app's brand colors are always applied and there's exactly one file to edit to reskin the app:

- `lib/core/constants/app_colors.dart` — this project's raw brand colors (`AppColors.primary`, `.error`, `.success`, `.warning`, `.info`, ...).
- `lib/core/constants/app_palette.dart` (`AppPalette.palette`) — `SldsPalette.defaultPalette` is already ported 1:1 (name and value) from `AppColors`, so this is currently a passthrough; override swatches here with `.copyWith(...)` to diverge from `AppColors` without touching the shared package.
- `lib/core/utils/theme/app_token_set.dart` (`AppTokenSet`) — `AppTokenSet.light()/dark()/highContrast()` return `SldsTokenSet`s built from `AppPalette.palette`. **This is what screens/theme entry points should call.**
- `lib/main_screen.dart` (`MyApp`) — wraps the tree in `SldsTheme(data: theme == ThemeMode.dark ? AppTokenSet.dark() : AppTokenSet.light(), ...)`, driven by `ThemeCubit`.

To rebrand a color app-wide: edit `AppColors` (and/or `AppPalette` if a new swatch/shade mapping is needed). Never hardcode a color or override `SldsTokenSet` colors ad hoc at a call site for a project-wide change — that's what `AppPalette` is for.

### Accessing tokens inside a widget

```dart
final tokens = context.slds;            // SldsTokenSet
final colors = context.slds.colors;      // SldsColorScheme
final dims   = context.slds.dimensions;  // SldsDimensionTokens
final typo   = context.slds.typography;  // SldsTypographyTokens
```

### Per-widget style overrides

Every component accepts a `style` parameter (`SldsButtonStyle`, `SldsInputStyle`, `SldsCardStyle`, etc.) with nullable fields — null means "inherit from the active token set". Use this for one-off instance overrides; use `AppPalette`/`AppColors` for anything that should apply everywhere.

```dart
SldsButton(
  style: const SldsButtonStyle(backgroundColor: Color(0xFF2E7D32)),
  onPressed: () {},
  child: const Text('Custom'),
)
```

## Everyday component usage

### SldsText — use instead of raw `Text` for on-brand copy

```dart
SldsText('Account overview') // default variant: body1
SldsText('Recent transactions', variant: SldsTextVariant.heading2)
SldsText(
  'Last updated 2 minutes ago',
  variant: SldsTextVariant.caption1,
  color: context.slds.colors.textSecondary,
)
```

Variants: `deckHeading1-4`, `display1-2`, `heading1-4`, `title1`, `body1`, `body2`, `caption1`, `caption2`, `overline`, `snackbarCaption`, `desktopTitle1`, `compactLabel`.

### SldsButton

```dart
SldsButton(onPressed: () {}, child: const Text('Submit'))                       // primary
SldsButton(variant: SldsButtonVariant.secondary, onPressed: () {}, child: ...)  // secondary/ghost/destructive
SldsButton(size: SldsButtonSize.extraLarge, onPressed: () {}, child: ...)       // small/medium/large/extraLarge
SldsButton(state: SldsComponentState.loading, onPressed: null, child: ...)      // loading
```

Taps are debounced 500ms by default (guards against double-submit); pass `debounceDuration: Duration.zero` to disable.

### Other Tier 1/2 components

`SldsInput`, `SldsTextArea`, `SldsDropdown`, `SldsCheckbox`, `SldsRadio`, `SldsToggle`, `SldsCard`, `SldsBadge`, `SldsTag`, `SldsChip`, `SldsAvatar`, `SldsListItem`, `SldsAccordion`, `SldsTabBar`, `SldsPagination`, `SldsProgress`, `SldsStepper`, `SldsNavigationDrawer`, `SldsDialog`, `SldsSnackbar`, `SldsTooltip` — see `packages/slds_flutter/USAGE_GUIDE.md` § 4 "Components" for the exact API of each.

## Notes specific to this app

- **Font**: `Google Sans` (the files ship inside `packages/slds_flutter/assets/fonts/`) is also declared in this app's own `pubspec.yaml` `fonts:` section (copied into `assets/fonts/`), and set as `GlobalTheme`'s default `fontFamily` (`lib/core/utils/theme/global_theme.dart`). This means both `SldsText` and any raw `Text`/`TextStyle` render in Google Sans. If a new project intentionally wants a different brand typeface, replace the font files in `assets/fonts/`, update `pubspec.yaml`'s `fonts:` entry and `GlobalTheme.themeData`'s `fontFamily`, and check `packages/slds_flutter/USAGE_GUIDE.md` for whether the package itself needs a matching override.
- `lib/core/utils/app_imports.dart` exports `slds_flutter` (`hide globalBorder`, since this project defines its own) alongside the rest of the common imports — most feature files should get SLDS components through that single import rather than importing `package:slds_flutter/slds_flutter.dart` directly.
- Localization: `slds_flutter` has no delegate to register — this app's own `lib/main_screen.dart` (`AppLocalizations.localizationsDelegates`, `en`/`ar`/`ne`) is the only localization system in play. Pass this app's `AppLocalizations` strings directly into the handful of SLDS component parameters listed in `USAGE_GUIDE.md` § "Localizations" (dismiss/search/pagination labels, etc) when a screen needs them translated.
- The package is versioned independently (`packages/slds_flutter/pubspec.yaml`, currently `0.2.0-alpha.0`) and has its own tests/docs under `packages/slds_flutter/docs/` (tier 1/2 component guidance, accessibility evidence) — consult those for accessibility or component-design questions beyond basic usage.
