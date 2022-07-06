import 'package:bloc/bloc.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../domain/entities/cart_entitiy.dart';
import '../../../domain/usecases/get_cart_usecase.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUseCase getCart;
  CartBloc({required this.getCart}) : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is GetCartEvent) {
        emit(LoadingCart());
        final failureOrCart = await getCart();
        failureOrCart.fold((failure) {
          emit(_mapFailureToState(failure));
        }, (carts) {
          emit(LoadedCart(carts: carts));
        });
      }
    });
  }
  CartState _mapFailureToState(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return const ErrorGetCart(
            message: 'Server Error Please Try again Later . ');
      case OfflineFailure:
        return const OfflineGetCartState(
            message: 'No internet Connection , please check your connection .');

      default:
        return const ErrorGetCart(
            message: 'Unexpected Error , please try again later .');
    }
  }
}
