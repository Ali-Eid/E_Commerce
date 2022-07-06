part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class PressSignUpEvent extends SignupEvent {
  final String name;
  final String email;
  final String password;
  final String phone;

  const PressSignUpEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });
  @override
  List<Object> get props => [name, email, password, phone];
}
