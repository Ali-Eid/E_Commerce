import 'package:bloc/bloc.dart';
import 'package:clean_architicture_ecommerce/core/error/failures/failures.dart';
import 'package:clean_architicture_ecommerce/core/error/strings/error_messages.dart';
import 'package:clean_architicture_ecommerce/features/auth/domain/usecases/logout_usecase.dart';
import 'package:equatable/equatable.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutUseCase logout;
  LogoutBloc({required this.logout}) : super(LogoutInitial()) {
    on<LogoutEvent>((event, emit) async {
      emit(LoadingLogoutState());
      final failureOrState = await logout();
      failureOrState.fold((failure) {
        emit(_mapFailureToState(failure));
      }, (message) {
        emit(SuccessLogoutState(message: message));
      });
    });
  }
  LogoutState _mapFailureToState(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return const ErrorLogoutState(message: SERVER_FAILURE_MESSAGE);
      case OfflineFailure:
        return const OfflineLogoutState(message: SERVER_FAILURE_MESSAGE);
      default:
        return const ErrorLogoutState(
            message: 'Unexpected Error , please try again later . ');
    }
  }
}
