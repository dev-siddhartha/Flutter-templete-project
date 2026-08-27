# Testing

This project tests at three levels — unit, widget, and integration. Each has a real, working example in the repo; copy the matching one instead of starting from scratch.

| Level | Example | Run |
|---|---|---|
| Unit (bloc) | `test/features/auth/login_bloc_test.dart` | `flutter test test/features/auth/login_bloc_test.dart` |
| Widget | `test/core/widgets/app_network_image_test.dart` | `flutter test test/core/widgets/app_network_image_test.dart` |
| Integration | `integration_test/app_test.dart` | `flutter test integration_test/app_test.dart -d <device-id>` |

Tooling: `flutter_test` (built in), `bloc_test` + `mocktail` (bloc/repo mocking), `integration_test` (SDK package). All are already in `pubspec.yaml`.

## Two gotchas specific to this codebase

Before writing a test here, know these — they're the reason the examples look the way they do:

1. **Many services resolve their dependencies via `getIt` internally, not through their constructor.** e.g. `LoginBloc._loginUser` calls `getIt<AuthRepo>()` directly inside the event handler, and `AuthService`'s fields are `getIt<SecureStorageService>()` / `getIt<SharedPrefsService>()` initializers. You can't just pass a mock to a constructor — you have to `getIt.registerSingleton<T>(mock)` in `setUp()` and `getIt.reset()` in `tearDown()`. See `login_bloc_test.dart` for the pattern. (If you're writing a *new* bloc/service, prefer real constructor injection — it's easier to test and this workaround won't be needed.)
2. **Any widget that reads `context.slds` needs both a `ScreenUtilInit` and an `SldsTheme` ancestor**, even in isolation — `SldsTokenSet` itself uses `flutter_screenutil`'s `.r`/`.w` internally, so building one without `ScreenUtilInit` above it throws a `LateInitializationError`. Wrap widgets under test the way `app_network_image_test.dart` does:
   ```dart
   ScreenUtilInit(
     builder: (context, _) => MaterialApp(
       home: SldsTheme(data: SldsTokenSet.light(), child: Scaffold(body: child)),
     ),
   )
   ```

## Unit tests (bloc/cubit and services)

Use `bloc_test`'s `blocTest` for any `Bloc`/`Cubit`. Mock repos/services with `mocktail` (no code generation, no `@GenerateMocks` needed).

```dart
class _MockAuthRepo extends Mock implements AuthRepo {}

blocTest<LoginBloc, LoginState>(
  'emits [loading, success] when loginUser succeeds',
  build: () {
    when(() => mockAuthRepo.loginUser(
      username: any(named: 'username'),
      password: any(named: 'password'),
    )).thenAnswer((_) async => Left({'data': {...}}));
    return LoginBloc();
  },
  act: (bloc) => bloc.add(const LoginUserEvent(username: 'u', password: 'p')),
  expect: () => [isA<LoginState>()..., isA<LoginState>()...],
);
```

Remember: this project's repo methods return `Either<dynamic, Failure>` (`fpdart`) — `Left` is the success payload, `Right` is the `Failure` (see `lib/core/services/api_service/api_service.dart`).

## Widget tests

Standard `flutter_test` + `WidgetTester`. For anything that renders text/inputs asynchronously (like `CachedNetworkImage`), assert on the state *before* `pumpAndSettle` if you want to catch the loading state — `pumpAndSettle` will wait until everything (including a failed network fetch) resolves.

## Integration tests

Live under `integration_test/`, use the `integration_test` SDK package, and run on a real device/emulator (`flutter test integration_test/app_test.dart -d <device-id>`) — that's what makes real platform channels (Firebase, secure storage, Hive) available, unlike plain `flutter test`. Boot the app the same way `lib/main_dev.dart` does — `EntryPoint().initializeApp(envType: EnvType.dev)` — then drive it with the normal `WidgetTester` API. Needs a real `.env.dev` and dev Firebase config in place first (see `.env.example` / the `*.example` files under `android/app/src/dev` and `ios/config/dev`).

## Compulsory: a unit test per completed feature

See `CLAUDE.md`'s Rules section — every completed feature (bloc/cubit event handler, repo method, non-trivial service method) needs at least one unit test covering its main success and failure paths before it's considered done.

## CI

`.gitlab-ci.yml` has a `test` stage (`flutter_test` job) that runs `flutter test --coverage` on every merge request, alongside the existing lint stage — so a broken or missing test now fails the pipeline, not just a formatting/analyze issue. It does **not** run `integration_test/` (that needs a real device/emulator, which the CI runner doesn't have) — run that manually or from a device-capable runner.

To check coverage locally: `flutter test --coverage` writes `coverage/lcov.info` (gitignored); view it with `genhtml coverage/lcov.info -o coverage/html && open coverage/html/index.html` (`genhtml` comes from `lcov` — `brew install lcov` if you don't have it).

## Recommendations for handling testing smoothly going forward

- **Track coverage, don't gate on a hard number yet.** Introducing a hard coverage threshold before the codebase has a real test base tends to produce low-value tests written just to hit the number — revisit once there's a meaningful baseline.
- **Prefer constructor injection for new blocs/services** over reaching into `getIt` mid-method — it's what made `LoginBloc` need the `getIt.registerSingleton` workaround in its test. Existing code doesn't need a mass rewrite, but new code should default to constructor injection so it's directly testable with `mocktail` mocks passed in, no `getIt` juggling.
- **Add a `mocktail`-based fake `AuthRepo`/`ApiRepo` factory** (a small `test/helpers/` file) once 3-4 tests need the same mock setup, instead of copy-pasting the `_MockAuthRepo` + `when()` boilerplate per test file.
- **Skip golden tests for now.** They're high-maintenance (re-recorded on every intentional design tweak) and this app's UI is still young; revisit once the design system usage stabilizes.
- **Run `integration_test/` in CI only if a device/emulator runner is available** (e.g. Firebase Test Lab, or a self-hosted runner with an emulator) — it's not worth wiring into a plain `.gitlab-ci.yml` lint job that has no device.
