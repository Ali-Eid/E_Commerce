part of 'add_delete_cart_bloc.dart';

abstract class AddDeleteCartEvent extends Equatable {
  const AddDeleteCartEvent();

  @override
  List<Object> get props => [];
}

class AddToCartEvent extends AddDeleteCartEvent {
  final CartEntity product;

  const AddToCartEvent({required this.product});
  @override
  List<Object> get props => [product];
}

class DeleteFromCartEvent extends AddDeleteCartEvent {
  final CartEntity product;

  const DeleteFromCartEvent({required this.product});
  @override
  List<Object> get props => [product];
}

class UpdateQuantityEvent extends AddDeleteCartEvent {
  final int quantity;
  final String cartid;

  const UpdateQuantityEvent({required this.quantity, required this.cartid});
  @override
  List<Object> get props => [cartid, quantity];
}
