import 'package:bloc/bloc.dart';
import 'package:clean_architicture_ecommerce/core/error/failures/failures.dart';
import 'package:clean_architicture_ecommerce/core/error/strings/error_messages.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/auth_entities.dart';
import '../../../domain/usecases/login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase login;
  LoginBloc({
    required this.login,
  }) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is PressLoginEvent) {
        emit(LoadingLoginState());
        final failureOrLogin = await login(event.username, event.password);
        emit(_mapFailureToState(failureOrLogin));
      }
    });
  }

  LoginState _mapFailureToState(Either<Failure, AuthEntities> either) {
    return either.fold(
        (failure) => ErrorLogin(message: _mapFailureToString(failure)),
        (authEntity) => SuccessLogin(authEntities: authEntity));
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case LoginFailure:
        return LOGIN_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error , please try again later . ';
    }
  }
}
