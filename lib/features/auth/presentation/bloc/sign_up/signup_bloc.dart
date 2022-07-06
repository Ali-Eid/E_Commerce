import 'package:bloc/bloc.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../../../core/error/strings/error_messages.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/entities/auth_entities.dart';
import '../../../domain/usecases/sign_up.dart';
import 'package:equatable/equatable.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignUpUseCase signUp;
  SignupBloc({required this.signUp}) : super(SignupInitial()) {
    on<SignupEvent>((event, emit) async {
      if (event is PressSignUpEvent) {
        emit(LoadingSignupState());
        final failureOrSignup = await signUp(
          event.name,
          event.email,
          event.password,
          event.phone,
        );
        emit(_mapFailureOrEntityToState(failureOrSignup));
      }
    });
  }

  SignupState _mapFailureOrEntityToState(Either<Failure, AuthEntities> either) {
    return either.fold(
        (failure) => ErrorSignupState(message: _mapFailureToString(failure)),
        (authEntity) => SuccessSignupState(authEntities: authEntity));
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case SignUpFailure:
        return SIGN_UP_FAILURE_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error , please try again later . ';
    }
  }
}
