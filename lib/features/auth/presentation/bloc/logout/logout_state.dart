part of 'logout_bloc.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LoadingLogoutState extends LogoutState {}

class SuccessLogoutState extends LogoutState {
  final String message;

  const SuccessLogoutState({required this.message});
}

class ErrorLogoutState extends LogoutState {
  final String message;

  const ErrorLogoutState({required this.message});
}

class OfflineLogoutState extends LogoutState {
  final String message;

  const OfflineLogoutState({required this.message});
}
