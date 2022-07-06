part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class LoadingSignupState extends SignupState {}

class SuccessSignupState extends SignupState {
  final AuthEntities authEntities;

  const SuccessSignupState({required this.authEntities});
}

class ErrorSignupState extends SignupState {
  final String message;

  const ErrorSignupState({required this.message});
}
