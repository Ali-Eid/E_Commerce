part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLogin extends LoginState {
  final AuthEntities authEntities;

  const SuccessLogin({required this.authEntities});
}

class ErrorLogin extends LoginState {
  final String message;

  const ErrorLogin({required this.message});
}
