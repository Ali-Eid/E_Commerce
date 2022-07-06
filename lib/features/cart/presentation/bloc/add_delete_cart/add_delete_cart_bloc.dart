import 'package:bloc/bloc.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../../../core/constants.dart';
import '../../../domain/entities/cart_entitiy.dart';
import '../../../domain/usecases/add_to_cart.dart';
import '../../../domain/usecases/update_quantity.dart';
import '../../../../products/domain/entities/products_entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'add_delete_cart_event.dart';
part 'add_delete_cart_state.dart';

class AddDeleteCartBloc extends Bloc<AddDeleteCartEvent, AddDeleteCartState> {
  final AddToCartUseCase addToCart;
  final UpdateQuantityUseCase updateQuantity;
  int? quantity = 1;
  GlobalKey keyCart = GlobalKey();
  AddDeleteCartBloc({
    required this.addToCart,
    required this.updateQuantity,
  }) : super(AddDeleteCartInitial()) {
    on<AddDeleteCartEvent>((event, emit) async {
      if (event is AddToCartEvent) {
        isCart[event.product.product.id] = !isCart[event.product.product.id];
        emit(LoadeAddCartState());
        final failureOrCart =
            await addToCart(event.product.product.id.toString());
        emit(changeLoadeAddCartState());
        failureOrCart.fold((l) {
          isCart[event.product.product.id] = !isCart[event.product.product.id];
          emit(
            ErrorAddCartState(
              message: l.toString(),
            ),
          );
        }, (cart) {
          emit(
            AddedCartState(cart: cart),
          );
        });
      } else if (event is DeleteFromCartEvent) {
        isCart[event.product.product.id] = !isCart[event.product.product.id];
        inCart.remove(event.product);
        emit(DeletedFavouriteProduct());
        final failureOrFavouriteAdd =
            await addToCart(event.product.product.id.toString());
        failureOrFavouriteAdd.fold((failure) {
          isCart[event.product.product.id] = !isCart[event.product.product.id];
          emit(_mapFailureToState(failure));
        }, (cart) {
          quantity = cart.quantity!;
          emit(SuccessDeletedCartState(cart: cart));
        });
      }
      //--------update quantity event
      else if (event is UpdateQuantityEvent) {
        emit(LoadingQuantity());
        final failureOrUpdate =
            await updateQuantity(event.cartid, event.quantity.toString());
        failureOrUpdate.fold((failure) {
          emit(_mapFailureToState(failure));
        }, (cart) => {emit(updatequantityState(cart: cart))});
      }
    });
  }
  AddDeleteCartState _mapFailureToState(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return const ErrorDeletedCartState(
            message: 'Server Error Please Try again Later . ');
      case OfflineFailure:
        return const OfflineDeletedCartState(
            message: 'No internet Connection , please check your connection .');

      default:
        return const ErrorDeletedCartState(
            message: 'Unexpected Error , please try again later .');
    }
  }
}
