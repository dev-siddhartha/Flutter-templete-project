// Example unit test - see docs/testing.md "Unit tests" for the pattern this follows.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_template/core/model/failure_model.dart';
import 'package:flutter_template/core/services/state/normal_state.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/secure_storage/secure_storage_service.dart';
import 'package:flutter_template/features/auth/domain/repo/auth_repo.dart';
import 'package:flutter_template/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepo extends Mock implements AuthRepo {}

class _MockSecureStorageService extends Mock implements SecureStorageService {}

class _MockSharedPrefsService extends Mock implements SharedPrefsService {}

void main() {
  late _MockAuthRepo mockAuthRepo;

  setUp(() {
    mockAuthRepo = _MockAuthRepo();

    // LoginBloc resolves its dependencies via getIt inside the event handler
    // rather than through its constructor, so mocks are registered in getIt
    // instead of being passed to LoginBloc() directly.
    getIt.registerSingleton<AuthRepo>(mockAuthRepo);
    getIt.registerSingleton<SecureStorageService>(_MockSecureStorageService());
    getIt.registerSingleton<SharedPrefsService>(_MockSharedPrefsService());

    final mockSecureStorage = getIt<SecureStorageService>();
    when(
      () => mockSecureStorage.writeSecureData(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
  });

  tearDown(() {
    getIt.reset();
  });

  group('LoginBloc', () {
    blocTest<LoginBloc, LoginState>(
      'emits [loading, success(true)] when loginUser succeeds',
      build: () {
        when(
          () => mockAuthRepo.loginUser(
            username: any(named: 'username'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (_) async => const Left({
            'data': {'accessToken': 'token', 'refreshToken': 'refresh'},
          }),
        );
        return LoginBloc();
      },
      act: (bloc) => bloc.add(
        const LoginUserEvent(username: 'user', password: 'pass'),
      ),
      expect: () => [
        isA<LoginState>().having(
          (s) => s.loginState,
          'loginState',
          isA<NormalLoadingState<bool>>(),
        ),
        isA<LoginState>().having(
          (s) => s.loginState,
          'loginState',
          isA<NormalSuccessState<bool>>(),
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [loading, failure] when loginUser returns a Failure',
      build: () {
        when(
          () => mockAuthRepo.loginUser(
            username: any(named: 'username'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (_) async => Right(Failure(message: 'Invalid credentials')),
        );
        return LoginBloc();
      },
      act: (bloc) => bloc.add(
        const LoginUserEvent(username: 'user', password: 'wrong'),
      ),
      expect: () => [
        isA<LoginState>().having(
          (s) => s.loginState,
          'loginState',
          isA<NormalLoadingState<bool>>(),
        ),
        isA<LoginState>()
            .having(
              (s) => s.loginState,
              'loginState',
              isA<NormalFailureState<bool>>(),
            )
            .having(
              (s) => s.loginState.failure?.message,
              'failure message',
              'Invalid credentials',
            ),
      ],
    );
  });
}
