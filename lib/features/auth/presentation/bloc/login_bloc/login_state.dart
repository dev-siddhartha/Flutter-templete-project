part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState({required this.loginState});

  final NormalState<bool> loginState;

  LoginState copyWith({NormalState<bool>? loginState});

  @override
  List<Object> get props => [loginState];
}

final class LoginStateImpl extends LoginState {
  const LoginStateImpl({super.loginState = const NormalInitialState<bool>()});

  @override
  LoginState copyWith({NormalState<bool>? loginState}) {
    return LoginStateImpl(loginState: loginState ?? this.loginState);
  }

  @override
  List<Object> get props => [loginState];
}

final class LoginInitial extends LoginState {
  const LoginInitial({super.loginState = const NormalInitialState<bool>()});

  @override
  LoginState copyWith({NormalState<bool>? loginState}) {
    return LoginInitial(loginState: loginState ?? this.loginState);
  }

  @override
  List<Object> get props => [loginState];
}
