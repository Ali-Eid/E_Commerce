part of 'add_delete_cart_bloc.dart';

abstract class AddDeleteCartState extends Equatable {
  const AddDeleteCartState();

  @override
  List<Object> get props => [];
}

class AddDeleteCartInitial extends AddDeleteCartState {}

class LoadeAddCartState extends AddDeleteCartState {}

class changeLoadeAddCartState extends AddDeleteCartState {}

class AddedCartState extends AddDeleteCartState {
  final CartEntity cart;

  const AddedCartState({required this.cart});
}

class ErrorAddCartState extends AddDeleteCartState {
  final String message;

  const ErrorAddCartState({required this.message});
}
//-------------------Delete From Cart-------------

class DeletedFavouriteProduct extends AddDeleteCartState {}

class SuccessDeletedCartState extends AddDeleteCartState {
  final CartEntity cart;

  const SuccessDeletedCartState({
    required this.cart,
  });
}

class ErrorDeletedCartState extends AddDeleteCartState {
  final String message;

  const ErrorDeletedCartState({required this.message});
}

class OfflineDeletedCartState extends AddDeleteCartState {
  final String message;

  const OfflineDeletedCartState({required this.message});
}
//-------------------update quantity-------------

class LoadingQuantity extends AddDeleteCartState {}

class updatequantityState extends AddDeleteCartState {
  final CartEntity cart;

  const updatequantityState({
    required this.cart,
  });
}
