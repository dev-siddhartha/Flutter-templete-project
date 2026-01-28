part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUserEvent extends LoginEvent {
  final String username;
  final String password;

  const LoginUserEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}
