# slds_flutter Usage Guide

Complete reference from first setup to every component.

---

## Table of Contents

1. [Setup](#1-setup)
2. [Theme Wiring](#2-theme-wiring)
3. [Token Customisation](#3-token-customisation)
   - [Palette Customisation](#palette-customisation)
   - [Localizations](#localizations)
   - [Per-Component Style Objects](#per-component-style-objects)
4. [Components](#4-components)
   - [SldsText](#sldstext)
   - [SldsButton](#sldsbutton)
   - [SldsInput](#sldsinput)
   - [SldsTextArea](#sldstextarea)
   - [SldsDropdown](#sldsdropdown)
   - [SldsCheckbox](#sldscheckbox)
   - [SldsRadio](#sldsradio)
   - [SldsToggle](#sldstoggle)
   - [SldsCard](#sldscard)
   - [SldsBadge](#sldsbadge)
   - [SldsTag](#sldstag)
   - [SldsChip](#sldschip)
   - [SldsAvatar](#sldsavatar)
   - [SldsListItem](#sldslistitem)
   - [SldsAccordion](#sldsaccordion)
   - [SldsTabBar](#sldstabbar)
   - [SldsPagination](#sldspagination)
   - [SldsProgressBar](#sldsprogressbar)
   - [SldsStepper](#sldsstepper)
   - [SldsNavigationDrawer](#sldsnavigationdrawer)
   - [SldsDialog](#sldsdialog)
   - [SldsSnackbar](#sldssnackbar)
   - [SldsTooltip](#sldstooltip)
5. [States Reference](#5-states-reference)
6. [Accessibility](#6-accessibility)
7. [Responsive Layout](#7-responsive-layout)
8. [Form Validation](#8-form-validation)

---

## 1. Setup

### pubspec.yaml

```yaml
dependencies:
  slds_flutter:
    path: ../packages/slds_flutter   # adjust to your relative path
```

Then run:

```sh
flutter pub get
```

### Fonts

The package uses **Google Sans**. Add the font to your host app's `pubspec.yaml` and copy the font files into an `assets/fonts/` directory, or load them from Google Fonts:

```yaml
flutter:
  fonts:
    - family: Google Sans
      fonts:
        - asset: assets/fonts/GoogleSans-Regular.ttf
          weight: 400
        - asset: assets/fonts/GoogleSans-Medium.ttf
          weight: 500
        - asset: assets/fonts/GoogleSans-Bold.ttf
          weight: 700
```

---

## 2. Theme Wiring

Wrap your widget tree with `SldsTheme` as high as possible — typically at the `MaterialApp` builder or directly around your top-level widget.

```dart
import 'package:slds_flutter/slds_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SldsTheme(
      data: SldsTokenSet.light(),
      child: MaterialApp(
        title: 'My App',
        home: const HomePage(),
      ),
    );
  }
}
```

### Dark Mode

```dart
SldsTheme(
  data: SldsTokenSet.dark(),
  child: MaterialApp(...),
)
```

### High Contrast

```dart
SldsTheme(
  data: SldsTokenSet.highContrast(),
  child: MaterialApp(...),
)
```

### Reduced Motion

```dart
SldsTheme(
  data: SldsTokenSet.light(reducedMotion: true),
  child: MaterialApp(...),
)
```

### Switching Modes at Runtime

```dart
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    final tokens = _brightness == Brightness.dark
        ? SldsTokenSet.dark()
        : SldsTokenSet.light();

    return SldsTheme(
      data: tokens,
      child: MaterialApp(
        home: HomePage(
          onToggleTheme: () => setState(
            () => _brightness = _brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
          ),
        ),
      ),
    );
  }
}
```

### Accessing Tokens Inside a Widget

```dart
final tokens = context.slds;            // SldsTokenSet
final colors = context.slds.colors;     // SldsColorScheme
final dims   = context.slds.dimensions; // SldsDimensionTokens
final typo   = context.slds.typography; // SldsTypographyTokens
```

---

## 3. Token Customisation

### Override a single semantic color

```dart
final brandTokens = SldsTokenSet.light().copyWith(
  colors: SldsTokenSet.light().colors.copyWith(
    buttonPrimaryBackground: const Color(0xFF0070D2),
    buttonPrimaryLabel: const Color(0xFFFFFFFF),
    buttonPrimaryHover: const Color(0xFF005FB2),
    focusRing: const Color(0xFF0070D2),
  ),
);

SldsTheme(data: brandTokens, child: ...)
```

### Nested override (mini-app scoped)

```dart
SldsTheme(
  data: context.slds.copyWith(
    colors: context.slds.colors.copyWith(
      buttonPrimaryBackground: const Color(0xFFE31837),
    ),
  ),
  child: MiniAppWidget(),
)
```

---

### Palette Customisation

The 3-layer color system lets you change a raw palette shade and have it propagate automatically through every semantic token that references it.

**`SldsPalette`** (`lib/src/tokens/slds_palette.dart`) has 10 `SldsColorSwatch` fields — `primary`, `neutral`, `red`, `green`, `teal`, `blue`, `orange`, `purple`, `maroon`, `darkSubtle` — each a shade map (`50`–`950`/`1000` depending on the swatch) accessed like `palette.primary[500]`, plus a `.call()`/`()` shortcut for the swatch's default shade.

#### Rebrand primary from gold to green

```dart
SldsTheme(
  data: SldsTokenSet.light(
    palette: SldsPalette.defaultPalette.copyWith(
      primary: SldsColorSwatch(500, {
        50: const Color(0xFFE8F5E9),
        100: const Color(0xFFC8E6C9),
        200: const Color(0xFFA5D6A7),
        300: const Color(0xFF81C784),
        400: const Color(0xFF4CAF50),
        500: const Color(0xFF388E3C), // main brand color — the swatch's default shade
        600: const Color(0xFF2E7D32),
        700: const Color(0xFF1B5E20),
        800: const Color(0xFF1B5E20),
        900: const Color(0xFF0D3D12),
      }),
    ),
  ),
  child: app,
)
```

Because `SldsColorScheme.light` maps `buttonPrimaryBackground → palette.primary[500]`, changing that shade automatically updates button backgrounds, focus rings, and every other token that references it — in all themes. See `lib/src/tokens/slds_color_tokens.dart` for the full list of semantic tokens and which palette shade each one maps to.

#### Per-mini-app palette

```dart
// Mini-app A uses blue, mini-app B uses red — both inside the same app:
SldsTheme(
  data: SldsTokenSet.light(
    palette: SldsPalette.defaultPalette.copyWith(
      primary: SldsColorSwatch(500, {
        50: const Color(0xFFE3F2FD),
        // ...
        500: const Color(0xFF1565C0),
        // ...
        900: const Color(0xFF0D47A1),
      }),
    ),
  ),
  child: MiniAppA(),
)
```

---

### Localizations

This package has no localization system of its own — no `SldsLocalizations`, no delegate to register. It's a generic component library and shouldn't own app-specific copy or locale decisions.

A handful of components have small built-in UI/accessibility strings (dismiss label, search placeholder, pagination labels, etc). Each is a plain optional constructor parameter with an English default; pass your own localized string (typically from your app's own generated `AppLocalizations`) at each call site to translate it:

```dart
SldsPagination(
  previousPageLabel: AppLocalizations.of(context).previousPage,
  nextPageLabel: AppLocalizations.of(context).nextPage,
  semanticLabel: AppLocalizations.of(context).paginationRegion,
  ...
)
```

The full list of overridable strings:

| Component      | Parameter           | English default            |
| --------------- | -------------------- | --------------------------- |
| `SldsSnackbar`  | `dismissSemanticLabel` | `'Dismiss'`                |
| `SldsPagination` | `previousPageLabel`  | `'Previous page'`           |
| `SldsPagination` | `nextPageLabel`      | `'Next page'`                |
| `SldsPagination` | `semanticLabel`      | `'Pagination'`                |
| `SldsDropdown`  | `searchPlaceholder`  | `'Search'`                    |
| `SldsDropdown`  | `noResultsLabel`     | `'No results'`                |
| `SldsStepper`   | `valueLabel`         | `'$currentStep of $totalSteps'` |

Leave a parameter unset to keep the English default.

---

### Per-Component Style Objects

Every component accepts a `style` parameter of its matching `SldsXxxStyle` class. All fields are nullable — null means "inherit from the active token set". This is the recommended way to override colors, typography, padding, and border radius on a single widget instance without touching the global theme.

```dart
// Button with a custom green background
SldsButton(
  style: const SldsButtonStyle(
    backgroundColor: Color(0xFF2E7D32),
    foregroundColor: Color(0xFFFFFFFF),
    borderRadius: 8,
  ),
  onPressed: () {},
  child: const Text('Custom'),
)

// Input with custom border and label colors
SldsInput(
  label: 'Email',
  style: const SldsInputStyle(
    borderColor: Color(0xFF1565C0),
    focusBorderColor: Color(0xFF0D47A1),
    labelColor: Color(0xFF1565C0),
  ),
)

// Card with a custom background
SldsCard(
  style: const SldsCardStyle(
    backgroundColor: Color(0xFFFFF8E1),
    borderRadius: 16,
  ),
  child: const Text('Warm card'),
)

// Badge with custom colors
SldsBadge(
  label: 'VIP',
  style: const SldsBadgeStyle(
    backgroundColor: Color(0xFF6A1B9A),
    foregroundColor: Color(0xFFFFFFFF),
    borderRadius: 4,
  ),
)

// Snackbar with custom title typography
SldsSnackbar(
  title: 'Done',
  style: SldsSnackbarStyle(
    titleStyle: Theme.of(context).textTheme.titleMedium,
  ),
)
```

All style classes support `copyWith()`:

```dart
const baseInputStyle = SldsInputStyle(borderRadius: 12);

// Reuse and extend
final errorInputStyle = baseInputStyle.copyWith(
  errorBorderColor: Color(0xFFB71C1C),
  errorStyle: TextStyle(fontWeight: FontWeight.w600),
);
```

---

## 4. Components

### SldsText

Renders a string using the active `SldsTokenSet`'s typography scale instead
of a hand-rolled `TextStyle`. Prefer this over a raw `Text` widget for any
on-brand copy so it stays theme-, palette-, and locale-aware.

```dart
// Default variant is body1
SldsText('Account overview')

// Heading
SldsText('Recent transactions', variant: SldsTextVariant.heading2)

// Caption with a custom color
SldsText(
  'Last updated 2 minutes ago',
  variant: SldsTextVariant.caption1,
  color: context.slds.colors.textSecondary,
)

// Full TextStyle override (bypasses the variant entirely)
SldsText(
  'Custom',
  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
)

// Same Text parameters you already use
SldsText(
  'Truncates after two lines…',
  variant: SldsTextVariant.body2,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  textAlign: TextAlign.center,
)
```

Available variants: `deckHeading1-4`, `display1-2`, `heading1-4`, `title1`,
`body1`, `body2`, `caption1`, `caption2`, `overline`, `snackbarCaption`,
`desktopTitle1`, `compactLabel` — one per `SldsTypographyTokens` field.

---

### SldsButton

```dart
// Primary (default)
SldsButton(
  onPressed: () {},
  child: const Text('Submit'),
)

// Secondary
SldsButton(
  variant: SldsButtonVariant.secondary,
  onPressed: () {},
  child: const Text('Cancel'),
)

// Ghost
SldsButton(
  variant: SldsButtonVariant.ghost,
  onPressed: () {},
  child: const Text('Learn more'),
)

// Destructive
SldsButton(
  variant: SldsButtonVariant.destructive,
  onPressed: () {},
  child: const Text('Delete'),
)

// With size (small / medium / large / extraLarge)
SldsButton(
  size: SldsButtonSize.extraLarge,
  onPressed: () {},
  child: const Text('Large action'),
)

// Debounced tap — default 500ms gap between accepted taps guards against
// accidental double-submit/double-navigation. Pass Duration.zero to disable.
SldsButton(
  debounceDuration: const Duration(seconds: 1),
  onPressed: _submit,
  child: const Text('Submit'),
)

// Full-width button
SldsButton(
  width: double.infinity,
  onPressed: () {},
  child: const Text('Fill parent'),
)

// Fixed width
SldsButton(
  width: 200,
  onPressed: () {},
  child: const Text('200px wide'),
)

// With leading icon
SldsButton(
  leading: const Icon(Icons.add),
  onPressed: () {},
  child: const Text('Add item'),
)

// Loading state
SldsButton(
  state: SldsComponentState.loading,
  onPressed: null,
  child: const Text('Saving...'),
)

// Disabled — either pass null or force the state
SldsButton(
  onPressed: null,
  child: const Text('Unavailable'),
)
```

---

### SldsInput

```dart
// Basic
SldsInput(
  label: 'Email',
  controller: _emailController,
  placeholder: 'you@example.com',
  keyboardType: TextInputType.emailAddress,
)

// With helper and error text
SldsInput(
  label: 'Username',
  helperText: 'Must be unique',
  errorText: 'Already taken',
  state: SldsComponentState.error,
)

// Password field
SldsInput(
  label: 'Password',
  controller: _passwordController,
  obscureText: true,
  trailing: IconButton(
    icon: const Icon(Icons.visibility),
    onPressed: () { /* toggle obscure */ },
  ),
)

// Read-only
SldsInput(
  label: 'Account ID',
  controller: TextEditingController(text: 'ACC-001'),
  readOnly: true,
)

// With validator inside a Form
Form(
  key: _formKey,
  child: SldsInput(
    label: 'Email',
    controller: _emailController,
    validator: (value) {
      if (value == null || value.isEmpty) return 'Required';
      if (!value.contains('@')) return 'Enter a valid email';
      return null;
    },
  ),
)

// Keyboard action + submit
SldsInput(
  label: 'Search',
  controller: _searchController,
  textInputAction: TextInputAction.search,
  onSubmitted: (value) => _search(value),
  leading: const Icon(Icons.search),
)

// Max length with digit-only restriction
import 'package:flutter/services.dart';

SldsInput(
  label: 'PIN',
  controller: _pinController,
  maxLength: 4,
  keyboardType: TextInputType.number,
  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
)

// External focus management
final _focusNode = FocusNode();
final _cityController = TextEditingController();

SldsInput(
  label: 'City',
  controller: _cityController,
  focusNode: _focusNode,
)

// Full width (fills its parent)
SldsInput(
  label: 'Notes',
  controller: _notesController,
  width: double.infinity,
)
```

---

### SldsTextArea

```dart
// Basic
SldsTextArea(
  label: 'Description',
  controller: _descController,
  placeholder: 'Enter a description...',
)

// With character counter
SldsTextArea(
  label: 'Bio',
  maxLength: 280,
  controller: _bioController,
)

// Taller area
SldsTextArea(
  label: 'Comments',
  height: 200,
)

// Full-width
SldsTextArea(
  label: 'Notes',
  width: double.infinity,
)

// With validator inside a Form
Form(
  key: _formKey,
  child: SldsTextArea(
    label: 'Reason',
    validator: (value) =>
        (value == null || value.trim().isEmpty) ? 'Required' : null,
  ),
)
```

---

### SldsDropdown

```dart
String? _selectedCountry;

SldsDropdown<String>(
  label: 'Country',
  placeholder: 'Select a country',
  items: const [
    SldsDropdownItem(value: 'lk', label: 'Sri Lanka'),
    SldsDropdownItem(value: 'in', label: 'India'),
    SldsDropdownItem(value: 'sg', label: 'Singapore'),
  ],
  value: _selectedCountry,
  onChanged: (value) => setState(() => _selectedCountry = value),
)

// With search (showSearch defaults to false)
SldsDropdown<String>(
  label: 'City',
  showSearch: true,
  searchPlaceholder: 'Type to filter...',
  items: _cities.map((c) => SldsDropdownItem(value: c, label: c)).toList(),
  value: _selectedCity,
  onChanged: (v) => setState(() => _selectedCity = v),
)

// Custom width
SldsDropdown<int>(
  label: 'Priority',
  width: double.infinity,
  items: const [
    SldsDropdownItem(value: 1, label: 'Low'),
    SldsDropdownItem(value: 2, label: 'Medium'),
    SldsDropdownItem(value: 3, label: 'High'),
  ],
  value: _priority,
  onChanged: (v) => setState(() => _priority = v),
)
```

---

### SldsCheckbox

```dart
bool _agreed = false;

SldsCheckbox(
  value: _agreed,
  label: 'I agree to the terms',
  onChanged: (value) => setState(() => _agreed = value),
)

// Small size (16px) — large (24px) is the default
SldsCheckbox(
  value: _selected,
  size: SldsCheckboxSize.defaultSize,
  onChanged: (v) => setState(() => _selected = v),
)

// Custom accent color
SldsCheckbox(
  value: _selected,
  activeColor: const Color(0xFF0070D2),
  onChanged: (v) => setState(() => _selected = v),
)

// Indeterminate (parent of a mixed selection)
SldsCheckbox(
  value: false,
  indeterminate: true,
  onChanged: (_) => _selectAll(),
)
```

---

### SldsRadio

```dart
String? _plan = 'basic';

Column(
  children: [
    SldsRadio<String>(
      value: 'basic',
      groupValue: _plan,
      label: 'Basic',
      onChanged: (v) => setState(() => _plan = v),
    ),
    SldsRadio<String>(
      value: 'pro',
      groupValue: _plan,
      label: 'Pro',
      onChanged: (v) => setState(() => _plan = v),
    ),
  ],
)

// Custom dot color
SldsRadio<String>(
  value: 'enterprise',
  groupValue: _plan,
  label: 'Enterprise',
  activeColor: const Color(0xFF0070D2),
  onChanged: (v) => setState(() => _plan = v),
)
```

---

### SldsToggle

```dart
bool _notifications = true;

SldsToggle(
  value: _notifications,
  onChanged: (v) => setState(() => _notifications = v),
)

// Disabled
SldsToggle(
  value: false,
  state: SldsComponentState.disabled,
  onChanged: null,
)
```

---

### SldsCard

```dart
// Basic content card
SldsCard(
  child: const Text('Hello from a card'),
)

// Auto-sizes to content (no forced minimum height)
SldsCard(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Text('Title'),
      Text('Sub-title'),
    ],
  ),
)

// Fixed dimensions
SldsCard(
  width: 300,
  height: 150,
  child: const Text('Fixed size'),
)

// Full-width
SldsCard(
  width: double.infinity,
  child: const Text('Fills parent'),
)

// Content with its own image/actions row — SldsCard has no dedicated
// image/actions slots, just child; compose them inside child instead
SldsCard(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network('https://example.com/photo.jpg', fit: BoxFit.cover),
      ),
      const Text('Card title'),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SldsButton(
            variant: SldsButtonVariant.ghost,
            onPressed: () {},
            child: const Text('Cancel'),
          ),
          SldsButton(
            onPressed: () {},
            child: const Text('Open'),
          ),
        ],
      ),
    ],
  ),
)

// Tappable card — semanticRole: button is required alongside onTap so the
// whole surface is exposed as a button to assistive tech
SldsCard(
  semanticRole: SldsCardSemanticsRole.button,
  onTap: () => Navigator.push(context, ...),
  child: const Text('Tap me'),
)

// Custom internal padding (defaults to space16 on all sides) — via style,
// not a direct constructor param
SldsCard(
  style: const SldsCardStyle(padding: EdgeInsets.all(24)),
  child: const Text('Roomier card'),
)

// Elevated variant
SldsCard(
  variant: SldsCardVariant.elevated,
  child: const Text('Elevated'),
)

// Circular shape (e.g. a floating action surface)
SldsCard(
  style: SldsCardStyle(
    padding: EdgeInsets.zero,
    shape: BoxShape.circle,
    backgroundColor: context.slds.colors.buttonPrimaryBackground,
  ),
  semanticRole: SldsCardSemanticsRole.button,
  onTap: () {},
  child: const Icon(Icons.add),
)
```

---

### SldsBadge

```dart
SldsBadge(label: 'Success', type: SldsBadgeType.success)
SldsBadge(label: 'Pending', type: SldsBadgeType.pending)
SldsBadge(label: 'Error',   type: SldsBadgeType.error)
SldsBadge(label: 'Info',    type: SldsBadgeType.info)
SldsBadge(label: 'In Review', type: SldsBadgeType.inReview)
SldsBadge(label: 'Approved',  type: SldsBadgeType.approved)
SldsBadge(label: 'On Hold',   type: SldsBadgeType.onHold)
```

---

### SldsTag

```dart
SldsTag(label: 'Draft',     type: SldsBadgeType.neutral)
SldsTag(label: 'Published', type: SldsBadgeType.success)
```

---

### SldsChip

```dart
SldsChip(
  label: 'Flutter',
  onDeleted: () => _removeTag('Flutter'),
)

// With leading icon
SldsChip(
  label: 'Design',
  leading: const Icon(Icons.palette),
  onDeleted: () {},
)

// With a leading avatar instead of an icon
SldsChip(
  label: 'Amal Silva',
  avatar: const SldsAvatar(initials: 'AS', size: SldsAvatarSize.size20),
  onDeleted: () {},
)
```

---

### SldsAvatar

```dart
// Initials — the content source (image / icon / initials) is picked by
// which single param you pass; SldsAvatar has no separate `variant` param.
// Defaults to initials "LK" if none of the three is provided.
SldsAvatar(
  initials: 'AS',
  size: SldsAvatarSize.size48,
)

// Network image
SldsAvatar(
  size: SldsAvatarSize.size48,
  image: const NetworkImage('https://example.com/avatar.jpg'),
)

// Icon
SldsAvatar(
  size: SldsAvatarSize.size32,
  icon: Icons.person,
)
```

---

### SldsListItem

```dart
// Basic
SldsListItem(
  title: 'Invoice #1042',
  description: 'Due 2026-08-01',
  onTap: () {},
)

// With leading icon and badge
SldsListItem(
  title: 'Payment received',
  description: 'LKR 45,000',
  leading: const Icon(Icons.receipt),
  badge: const SldsBadge(label: 'Success', type: SldsBadgeType.success),
  onTap: () {},
)

// Multiline
SldsListItem(
  title: 'Long title that wraps across multiple lines when needed',
  description: 'Equally long description text',
  maxLines: 2,
  onTap: () {},
)

// Full-width
SldsListItem(
  title: 'Full width item',
  width: double.infinity,
)

// Empty state with localizable description
SldsListItem(
  title: 'No transactions',
  state: SldsComponentState.empty,
  emptyDescription: 'No transactions found',  // replaces hardcoded 'No details available'
)
```

---

### SldsAccordion

```dart
SldsAccordion(
  title: 'What documents do I need?',
  expanded: _isOpen,
  onChanged: (open) => setState(() => _isOpen = open),
  child: const Text('You need your NIC and proof of address.'),
)

// Custom width
SldsAccordion(
  title: 'FAQ',
  width: double.infinity,
  expanded: _isOpen,
  onChanged: (v) => setState(() => _isOpen = v),
  child: const Text('Answer here.'),
)
```

---

### SldsTabBar

```dart
int _selectedTab = 0;

SldsTabBar(
  items: const [
    SldsTabItem(label: 'Overview'),
    SldsTabItem(label: 'Transactions', badgeCount: 3),
    SldsTabItem(label: 'Documents'),
  ],
  selectedIndex: _selectedTab,
  onChanged: (index) => setState(() => _selectedTab = index),
)

// Full-width strip
SldsTabBar(
  width: double.infinity,
  items: const [
    SldsTabItem(label: 'All'),
    SldsTabItem(label: 'Active'),
    SldsTabItem(label: 'Closed'),
  ],
  selectedIndex: _selectedTab,
  onChanged: (i) => setState(() => _selectedTab = i),
)
```

---

### SldsPagination

```dart
SldsPagination(
  currentPage: _page,
  totalPages: 20,
  onPageChanged: (page) => setState(() => _page = page),
)

// Localised navigation labels
SldsPagination(
  currentPage: _page,
  totalPages: 20,
  previousPageLabel: AppLocalizations.of(context).previousPage,
  nextPageLabel: AppLocalizations.of(context).nextPage,
  onPageChanged: (page) => setState(() => _page = page),
)
```

---

### SldsProgressBar

```dart
SldsProgressBar(value: 65)

// Without label
SldsProgressBar(value: 30, showLabel: false)

// Full-width
SldsProgressBar(value: 45, width: double.infinity)

// Error state
SldsProgressBar(
  value: 20,
  state: SldsComponentState.error,
)

// Accessible label
SldsProgressBar(
  value: 75,
  semanticLabel: 'Upload progress',
)
```

---

### SldsStepper

```dart
SldsStepper(
  totalSteps: 4,
  currentStep: 2,
)

// Full-width
SldsStepper(
  totalSteps: 5,
  currentStep: 3,
  width: double.infinity,
  semanticLabel: 'Step 3 of 5',
)
```

---

### SldsNavigationDrawer

```dart
SldsNavigationDrawer(
  title: 'My App',
  items: [
    SldsNavigationDrawerItem(
      label: 'Dashboard',
      icon: Icons.home,
      selected: _route == 'dashboard',
      onTap: () => setState(() => _route = 'dashboard'),
    ),
    SldsNavigationDrawerItem(
      label: 'Transactions',
      icon: Icons.receipt_long,
      selected: _route == 'transactions',
      onTap: () => setState(() => _route = 'transactions'),
    ),
    SldsNavigationDrawerItem(
      label: 'Profile',
      icon: Icons.person,
      selected: _route == 'profile',
      onTap: () => setState(() => _route = 'profile'),
    ),
  ],
  footer: SldsButton(
    variant: SldsButtonVariant.ghost,
    onPressed: _logout,
    child: const Text('Sign out'),
  ),
)
```

---

### SldsDialog

`SldsDialog` is the dialog body only — it has no `.show()` convenience and no
`onDismiss`/header-close-button param. Wrap it in Flutter's own `showDialog` +
`Dialog`:

```dart
showDialog(
  context: context,
  builder: (ctx) => Dialog(
    child: SldsDialog(
      title: 'Confirm action',
      message: 'Are you sure you want to delete this item? This cannot be undone.',
      primaryAction: SldsButton(
        variant: SldsButtonVariant.destructive,
        onPressed: () {
          _deleteItem();
          Navigator.of(ctx).pop();
        },
        child: const Text('Delete'),
      ),
      secondaryAction: SldsButton(
        variant: SldsButtonVariant.secondary,
        onPressed: () => Navigator.of(ctx).pop(),
        child: const Text('Cancel'),
      ),
    ),
  ),
);

// With localizable fallback button (no primaryAction)
SldsDialog(
  title: 'Session expired',
  message: 'Your session has expired. Please log in again.',
  fallbackActionLabel: AppLocalizations.of(context).close,
  onFallbackAction: () => Navigator.of(context).pop(),
)

// Custom width
SldsDialog(
  title: 'Info',
  message: 'Full message here.',
  width: 400,
  primaryAction: SldsButton(
    onPressed: () {},
    child: const Text('OK'),
  ),
)
```

---

### SldsSnackbar

Snackbars are positioned and shown by the host app (e.g. using `Overlay` or a
`Stack`). The widget itself is purely presentational.

```dart
// Basic
SldsSnackbar(title: 'Changes saved')

// With description
SldsSnackbar(
  title: 'Upload complete',
  description: 'Your file has been uploaded successfully.',
)

// With action
SldsSnackbar(
  title: 'Item deleted',
  actionLabel: 'Undo',
  onAction: _undoDelete,
)

// With dismiss button
SldsSnackbar(
  title: 'New message received',
  onDismiss: _hideSnackbar,
  dismissSemanticLabel: AppLocalizations.of(context).dismiss,
)

// Error state
SldsSnackbar(
  title: 'Upload failed',
  description: 'Please check your connection and try again.',
  state: SldsComponentState.error,
  onDismiss: _hideSnackbar,
)

// Custom width
SldsSnackbar(
  title: 'Saved',
  width: double.infinity,
)
```

#### Showing a snackbar using Overlay

```dart
OverlayEntry? _entry;

void _showSnackbar() {
  _entry = OverlayEntry(
    builder: (_) => Positioned(
      bottom: 24,
      left: 16,
      right: 16,
      child: SldsSnackbar(
        title: 'Changes saved',
        width: double.infinity,
        onDismiss: _hideSnackbar,
      ),
    ),
  );
  Overlay.of(context).insert(_entry!);
  Future.delayed(const Duration(seconds: 4), _hideSnackbar);
}

void _hideSnackbar() {
  _entry?.remove();
  _entry = null;
}
```

---

### SldsTooltip

`SldsTooltip` is a static container; visibility is managed by the caller.

```dart
// Title-only tooltip
if (_showTip)
  SldsTooltip(
    title: 'Required field',
    variant: SldsTooltipVariant.title,
  )

// With description
if (_showTip)
  SldsTooltip(
    title: 'Password strength',
    description: 'Use at least 8 characters, a number and a symbol.',
    variant: SldsTooltipVariant.titleDescription,
  )
```

---

## 5. States Reference

All interactive components accept an optional `state` parameter of type
`SldsComponentState`.

| State | Meaning |
|-------|---------|
| `defaultState` | Normal resting state |
| `hover` | Mouse/pointer hovering |
| `focus` | Keyboard focus ring visible |
| `active` | Pressed / selected |
| `disabled` | Greyed out; non-interactive |
| `loading` | In-progress; spinner shown |
| `error` | Error colour applied |
| `success` | Success colour applied |
| `empty` | No data to show |

Most components derive their interactive state automatically from gestures and
focus. Pass `state` explicitly only for documentation previews, Storybook-style
showcases, or to force a visual state in tests.

---

## 6. Accessibility

Every component includes:

- `Semantics` wrapper with appropriate roles (`button`, `textField`, `checked`, etc.)
- Focus ring (yellow halo, `sldsFocusRing`) on keyboard focus
- `FocusableActionDetector` so components respond to `Enter`/`Space` keyboard events

### Tips

- Always provide `semanticLabel` for icon-only buttons.
- Pass `previousPageLabel` / `nextPageLabel` in `SldsPagination` as localised strings.
- Pass `dismissSemanticLabel` in `SldsSnackbar` as a localised string.
- Pass `emptyDescription` in `SldsListItem` as a localised string.
- Wrap forms in a `Form` widget and use the `validator` param on `SldsInput` / `SldsTextArea`.

---

## 7. Responsive Layout

Every component that previously had a hardcoded Figma width now accepts a
`width` parameter.

### Make a component fill its parent

```dart
SldsInput(label: 'Search', width: double.infinity)
SldsButton(child: const Text('Submit'), width: double.infinity)
SldsCard(child: content, width: double.infinity)
SldsProgressBar(value: 50, width: double.infinity)
```

### Use LayoutBuilder to respond to constraints

```dart
LayoutBuilder(
  builder: (context, constraints) {
    final inputWidth = constraints.maxWidth < 480
        ? constraints.maxWidth
        : 361.0;
    return SldsInput(label: 'Email', width: inputWidth);
  },
)
```

### Use a full-width tab strip on mobile

```dart
SldsTabBar(
  width: double.infinity,
  items: _tabs,
  selectedIndex: _tab,
  onChanged: (i) => setState(() => _tab = i),
)
```

---

## 8. Form Validation

`SldsInput` and `SldsTextArea` use `TextFormField` internally. Wrap them in a
`Form` to enable standard Flutter validation.

```dart
final _formKey = GlobalKey<FormState>();
final _emailCtrl = TextEditingController();
final _messageCtrl = TextEditingController();

Form(
  key: _formKey,
  child: Column(
    children: [
      SldsInput(
        label: 'Email',
        controller: _emailCtrl,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: (v) {
          if (v == null || v.isEmpty) return 'Required';
          if (!v.contains('@')) return 'Enter a valid email';
          return null;
        },
      ),
      const SizedBox(height: 16),
      SldsTextArea(
        label: 'Message',
        controller: _messageCtrl,
        maxLength: 500,
        validator: (v) =>
            (v == null || v.trim().isEmpty) ? 'Required' : null,
      ),
      const SizedBox(height: 24),
      SldsButton(
        width: double.infinity,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _submit();
          }
        },
        child: const Text('Send'),
      ),
    ],
  ),
)
```

### Error state after submission

```dart
// Show server-side error on the input
SldsInput(
  label: 'Email',
  controller: _emailCtrl,
  state: _serverError ? SldsComponentState.error : SldsComponentState.defaultState,
  errorText: _serverError ? 'This email is already registered' : null,
)
```
