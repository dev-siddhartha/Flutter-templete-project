# Flutter templete
This is a templete project with all basic setup completed and support for web

Current Flutter Version -> 3.44.0
Current Dart Version -> 3.12.0

## What's Included?
This Flutter project includes the following features and components:

### Features
- **Flutter Flavors**: Supports multiple environments (e.g., dev, staging, production) for easy configuration.
- **Screen Responsiveness**: Utilizes `flutter_screenutil` to adapt UI components dynamically across different screen sizes.
- **Theme Switching**: Implements dark and light mode with data managed via shared preferences.
- **Dependency Injection**: Uses `getIt` for service locator-based dependency injection.
- **State Management**: Utilizes `Flutter Bloc` for efficient and scalable state management.
- **Testing**: `bloc_test`/`mocktail` for unit tests, `integration_test` for end-to-end. See [docs/testing.md](docs/testing.md) for the project's patterns and working examples.

### Components
- **Device Info Service**: Get all required device data for android, ios and web.
- **App Imports**: Centralized file containing all basic imports.
- **App Extensions**:
  - Dark mode support.
  - String casing utilities.
  - TextStyle extensions.
  - Base API Extensions - Parse data from map or list to Given Object or List
- **Design System**: UI is built on the local `slds_flutter` package (`packages/slds_flutter`) — themed components (`SldsText`, `SldsButton`, `SldsInput`, ...) instead of raw Material widgets. See [docs/design_system.md](docs/design_system.md) and `packages/slds_flutter/USAGE_GUIDE.md`.
- **Parse Service**: Handles type parsing with error management.
- **Constants**:
  - Color definitions.
  - Environment configurations.
  - Theme settings.
  - Preference keys.
- **Localization Support**: Implement multi-language support.
- **Routing Improvements**: Enhance navigation structure with a robust routing mechanism - goRouter.
- **API Service**:
  - Handles fetching of normal or paginated data and parse into [Object] or [PaginatedModel] with help of [base_api_extension].

  #### Example Of Api Service using flutter bloc
  > Use this inside your bloc for api calling

  Pagination API:

  ```dart
  Future<void> _getPaginatedDataExample(
      GetPaginatedDataEvent event, Emitter<PaginatedDataState> emit) async {
    if (event.refresh) {
      emit(state.copyWith(
          paginatedDataState: const PaginationLoadingState()));
    }

    if (state.paginatedDataState.currentPage <=
        state.paginatedDataState.lastPage) {
      PaginationState<PaginatedDataModel> dataPaginationState =
          await ApiService.fetchPaginatedData<PaginatedDataModel>(
        currentState: state.paginatedDataState,
        apiCall: () => getIt<ApiRepo>().getPaginatedDataApiSample(
          pageNo: state.paginatedDataState.currentPage,
        ),
        fromJson: PaginatedDataModel.fromJson,
      );

      emit(state.copyWith(paginatedDataState: dataPaginationState));
    }
  }
  ```

  Normal API:
  
  ```dart
  Future<void> _getNormalDataExample(GetNormalEvent event, Emitter<NormalDataState> emit) async {
    emit(state.copyWith(normalDataState: const NormalLoadingState()));

    final result = await ApiService.fetchNormalData(
      apiCall: () =>
          getIt<ApiRepo>().getNormalDataApiSample(someParams: event.someParams),
      fromJson: NormalDataModel.fromJson,
    );
    emit(state.copyWith(normalDataState: result));
  }
  ```

## Setup Guide

`.env.dev`/`.env.prod` and the per-flavor Firebase config files (`android/app/src/{dev,prod}/google-services.json`, `ios/config/{dev,prod}/GoogleService-Info.plist`) are gitignored, so a plain clone of this repo does **not** include them - only their `.example` counterparts do. Which of the two setups below you follow determines whether that gap gets handled for you.

### Option 1: via `siddhartha_cli` (new project, recommended)

`siddhartha_cli create` clones this template, renames the app/package everywhere (pubspec name, Android `namespace`/`applicationId` + the Kotlin source folder, iOS bundle ID), seeds `.env.dev`/`.env.prod` and the Firebase config files from their `.example` templates with the new package name already applied, then runs `flutter pub get`, `pod install` (macOS only), `dart run build_runner build`, and `git init` automatically.

```bash
dart pub global activate siddhartha_cli   # once
siddhartha_cli create
```

After it finishes, `cd <project> && flutter run --flavor dev -t lib/main_dev.dart` should just work. The only things still worth doing (also printed at the end of the command):
1. Replace the seeded Firebase config with real files from the Firebase console before using push notifications/Crashlytics (the API keys are placeholders until then - everything else works fine without them).
2. Put a real `BASE_URL` in `.env.dev`/`.env.prod` (seeded with a placeholder).
3. For a real Android release build: copy `android/key.properties.example` to `android/key.properties` and fill in your keystore (falls back to debug signing until then).
4. Check `pod --version` is reasonably current if the automatic `pod install` step failed - a too-old CocoaPods can't parse this project's Xcode 16 project format.

### Option 2: manual clone (working on this template itself)

Nothing promotes the `.example` files for you here - do it by hand:

1. Clone the repository, then run `flutter pub get`.
2. Copy the `.example` files to their real names:
   ```bash
   cp .env.example .env.dev
   cp .env.example .env.prod
   cp android/app/src/dev/google-services.json.example android/app/src/dev/google-services.json
   cp android/app/src/prod/google-services.json.example android/app/src/prod/google-services.json
   cp ios/config/dev/GoogleService-Info.plist.example ios/config/dev/GoogleService-Info.plist
   cp ios/config/prod/GoogleService-Info.plist.example ios/config/prod/GoogleService-Info.plist
   ```
   The placeholder `package_name`/`BUNDLE_ID` inside those files already match this template's own `com.siddhartha.templete[.dev]`, so this is enough to build as-is. Fill in real values (`.env` URLs, real Firebase files) whenever you actually need them.
3. iOS: `cd ios && pod install`.
4. Run the app: `flutter run --flavor dev -t lib/main_dev.dart` (or `prod` / `lib/main_prod.dart`).

See [CLAUDE.md](CLAUDE.md) for the full command reference and architecture notes.

## Contributions
Contributions are welcome! Please submit a pull request with your changes.

## License
This project is open-source and available under the MIT License.


# To format dart file

``` bash
dart format .
```