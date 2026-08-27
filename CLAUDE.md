# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

A Flutter starter template (Flutter 3.44.0 / Dart 3.12.0, SDK constraint `^3.12.0`) with flavors, theming, DI, state management, networking, and localization pre-wired. New apps are built by cloning/copying this template, so changes here should stay generic rather than app-specific.

## Rules (strict — every session must follow)

- **Design system**: before writing or touching any UI code, read `docs/design_system.md`. Build screens with `slds_flutter` components/tokens (`SldsText`, `SldsButton`, `SldsInput`, `AppTokenSet`, etc.) — never raw Material widgets, hardcoded colors, or hand-rolled `TextStyle`s where an SLDS equivalent exists. Project-wide color changes go through `AppColors`/`AppPalette`, never a one-off override.
- **Comments**: do not write comments unless absolutely necessary. No comments that restate what the code already says. Only comment a non-obvious *why* — a hidden constraint, a workaround, a subtle invariant — never the *what*. Default to zero comments; when in doubt, leave it out.
- **Testing**: before writing or touching any UI code, read `docs/testing.md`. Once a feature (a bloc/cubit event handler, repo method, or non-trivial service method) is complete, writing a unit test covering its main success and failure paths is compulsory — not optional, not deferred to "later." Follow the patterns and gotchas (`getIt` mocking, `SldsTheme` wrapping) documented there rather than inventing a new approach per file.

## Commands

```bash
# install deps (run after any pubspec.yaml change, including in packages/slds_flutter)
flutter pub get

# run
flutter run --flavor dev -t lib/main_dev.dart
flutter run --flavor prod -t lib/main_prod.dart

# build
flutter build apk --flavor dev -t lib/main_dev.dart
flutter build ipa --flavor prod -t lib/main_prod.dart

# regenerate injectable DI bindings (lib/injectable/injectable.config.dart)
# run after adding/changing any @injectable/@singleton/@lazySingleton class
dart run build_runner build --delete-conflicting-outputs

# regenerate localization (lib/l10n/app_localizations*.dart)
# run after editing lib/l10n/app_en.arb (or app_ar.arb / app_ne.arb)
flutter gen-l10n

# format
dart format .

# lint / static analysis
flutter analyze

# tests (see docs/testing.md) - compulsory for every completed feature
flutter test
flutter test test/features/auth/login_bloc_test.dart   # single file
flutter test --coverage

# integration tests - needs a connected device/emulator
flutter test integration_test/app_test.dart -d <device-id>

# regenerate app icons from assets/icon/icon.png (see flutter_launcher_icons.yaml)
dart run flutter_launcher_icons

# regenerate native splash screens from assets/icon/icon.png (see flutter_native_splash.yaml)
dart run flutter_native_splash:create

# one-time per clone: run the pre-commit hook (format + analyze) locally before pushing
git config core.hooksPath .githooks
```

There are two entry points, not one `main.dart`: `lib/main_dev.dart` and `lib/main_prod.dart`, each calling `EntryPoint().initializeApp(envType: ...)`. Android/iOS flavors are named `dev`/`prod` and must match the `-t` entry point and `--flavor` used together. Each flavor loads its own env file (`.env.dev` / `.env.prod`) via `flutter_dotenv`.

`.env.dev`/`.env.prod` and the per-flavor `google-services.json`/`GoogleService-Info.plist` are gitignored (see the `*.example` files next to each) — on a fresh clone, copy each `.example` to its real filename and fill in real values before `flutter pub get`/`flutter run`, since `pubspec.yaml`'s `assets:` list requires `.env.dev`/`.env.prod` to exist.

## Architecture

### Local design-system package

`packages/slds_flutter` is a local path-dependency package (`slds_flutter`, referenced in `pubspec.yaml` via `path: packages/slds_flutter`) implementing the SLDS Alpha design system — theme tokens, typography, and components. The app never calls `SldsTokenSet.light/dark/highContrast()` directly; instead `lib/core/utils/theme/app_token_set.dart` (`AppTokenSet`) wraps those calls with the project's `AppPalette` (`lib/core/constants/app_palette.dart`). This makes `AppPalette` the single file to edit to reskin the whole app. `lib/core/utils/theme/global_theme.dart` builds the `ThemeData` consumed by `MaterialApp.router`, while `SldsTheme` (from the package) wraps the widget tree with the raw token set for components that read tokens directly.

### App bootstrap (`lib/entry_point.dart`)

`EntryPoint.initializeApp` runs a fixed sequence — order matters, don't reorder without understanding why:
1. `dotenv.load` — loads the flavor's env file.
2. `configureDependencies()` — initializes the `get_it`/`injectable` service locator (`getIt`).
3. `getIt<HiveInitializer>().init()` — **must run before `NetworkService`**. It points Hive at the app-support directory (not Documents, which is visible in the iOS Files app) and opens the `api_cache` box first so that `api_request_handler`'s internal `CacheService` — which re-inits Hive against Documents on first use — finds the box already open and becomes a no-op. It also opens an AES-encrypted `secure` box keyed by a random key stored in secure storage.
4. `NetworkService.initilizeNetworkService()` then `AbsFirebaseService.initializeFirebase()`.
5. `AuthCubit.checkLogin()` — kicks off auth-state resolution asynchronously; the UI reacts to it later via `BlocListener<AuthCubit, bool>` in `MyApp` (see below), not by awaiting here.

### Feature structure

Each feature under `lib/features/<feature>/` follows data/domain/presentation layering:
- `domain/repo/` — abstract repo interface; `domain/model/` — domain models.
- `data/repo_impl/` — repo implementation; `data/service/` — raw API/service calls.
- `presentation/bloc/` (or `cubit/`) — one bloc/cubit subfolder per unit of state; `presentation/screens/`, `presentation/widgets/`.

Cross-feature/global state (auth, theme, language) is not a "feature" — it lives in `lib/core/cubits/` and `lib/features/auth/presentation/bloc/auth_cubit/`, and is registered app-wide via `GlobalBlocProvider` (`lib/core/utils/global_bloc_provider.dart`), consumed by `MultiBlocProvider` in `lib/main_screen.dart`'s `MyApp`.

`AuthCubit`'s boolean state drives top-level navigation: `MyApp` listens to it and calls `NavigationService.pushAndRemoveUntil` to the dashboard or login route, and `RouteConfig`'s initial route also redirects based on `getIt<AuthCubit>().state`. Routes are defined in `lib/core/routes/route_config.dart` (GoRouter) with names centralized in `lib/core/routes/route_names.dart`.

### DI (get_it + injectable)

`lib/injectable/injectable.dart` wires `configureDependencies()` to the generated `lib/injectable/injectable.config.dart`. Classes are registered by annotating them (`@singleton`, `@lazySingleton`, `@injectable`, or binding an impl to an abstract repo/service via `@Injectable(as: ...)`) — never by hand-editing the generated config. After adding/removing/changing such an annotation, regenerate with `build_runner` (command above); the generated file is checked in, so commit it alongside the source change.

### Networking / API layer

Built on `dio` + the `api_request_handler` package, returning `Either<dynamic, Failure>` (via `fpdart`) from repo calls — `Left` is success payload, `Right` is `Failure`. `lib/core/services/api_service/api_service.dart` (`ApiService`) is the layer blocs call into; it has three static helpers:
- `fetchNormalData` — single object response, parsed via a `fromJson`.
- `fetchNormalListData` — list response.
- `fetchPaginatedData` — paginated list response, accumulates pages into a `PaginationSuccessState` (see `lib/core/services/state/pagination_state.dart`), driven by a `PaginationModel` (`page`/`pageNumber`/`totalPage`/`totalElement`).

Each returns a sealed `NormalState`/`PaginationState` (loading/success/failure) for blocs to emit directly. See the README for the canonical bloc usage pattern for both normal and paginated calls.

### Storage

Three distinct storage layers, each for a different purpose — don't mix them up:
- `lib/core/utils/shared_preferences/` — `shared_preferences`, for simple non-sensitive key/value app state (keys in `lib/core/constants/shared_prefs_keys.dart`).
- `lib/core/utils/secure_storage/` — `flutter_secure_storage`, for sensitive values (tokens, the Hive encryption key; keys in `lib/core/constants/secured_storage_keys.dart`).
- `lib/core/storage/cache/hive/` — Hive boxes for structured local caching, including the API cache used transparently by `api_request_handler` and an AES-encrypted `secure` box (see `HiveInitializer` above; box names in `hive_keys.dart`).

### Localization

ARB-based, driven by `l10n.yaml` (arb dir `lib/l10n/`, template `app_en.arb`). Supported locales: `en`, `ar`, `ne`. Edit the `.arb` files, then run `flutter gen-l10n` to regenerate `app_localizations*.dart` — never hand-edit the generated files. Active locale is app-level state via `LanguageCubit` (`lib/core/cubits/language_cubit/`), consumed by `MaterialApp.router`'s `locale`/`supportedLocales`/`localizationsDelegates`.

### Theming

`ThemeCubit` (`lib/core/cubits/theme_cubit/`) holds light/dark `ThemeMode`, persisted via shared preferences. `MyApp` feeds both the SLDS `SldsTheme` (token-based) and Flutter's own `ThemeData` (`GlobalTheme.lightThemeData`/`darkThemeData`) from the same `ThemeMode`, wrapped in an `AnimatedTheme` for animated transitions — a theme change must stay reflected in both places.

### Centralized imports

`lib/core/utils/app_imports.dart` re-exports the common Flutter/package/project imports (material, screenutil, colors, extensions, shared prefs, DI, routing, widgets, localization, theming). Most feature files import this single file instead of importing each of those individually — follow that convention for new files that need several of these.

### iOS export compliance

`ios/Runner/Info.plist` sets `ITSAppUsesNonExemptEncryption = false` so App Store Connect/TestFlight uploads skip the manual encryption-compliance question. This is correct only while the app uses no encryption beyond standard HTTPS/TLS — an app built from this template that adds custom/non-exempt encryption must override this.

### Android release signing

`android/app/build.gradle.kts` signs release builds with a real keystore when `android/key.properties` exists (copy `android/key.properties.example` and fill in real values), and falls back to the debug keystore when it doesn't — so `flutter run --release` keeps working out of the box, but that fallback build is **not** suitable for a Play Store upload. `key.properties` is gitignored.

### Biometric auth

`lib/core/services/biometric/` (`BiometricService`/`BiometricServiceImpl`, wired the same DI way as other services) wraps `local_auth` with `isBiometricAvailable()`/`authenticate()`. Android's `MainActivity` extends `FlutterFragmentActivity` (not the default `FlutterActivity`) because `local_auth` needs a `FragmentActivity` to show the biometric prompt — don't revert that. iOS needs `NSFaceIDUsageDescription` in `Info.plist` (already set) or Face ID silently fails.

### Network images

`lib/core/widgets/app_network_image.dart` (`AppNetworkImage`, exported via `app_imports.dart`) wraps `cached_network_image` with themed loading/error placeholders. Use it instead of a raw `Image.network` anywhere a remote image is shown.

### App icon / splash screen

Generated via `flutter_launcher_icons.yaml` / `flutter_native_splash.yaml` (both at repo root) from the single source image `assets/icon/icon.png`, which is currently a placeholder — replace it with the project's real icon, update the `color`/`color_dark` in `flutter_native_splash.yaml` to the real brand background, then re-run both generators (commands above).
