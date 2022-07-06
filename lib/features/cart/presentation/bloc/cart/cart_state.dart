part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class LoadingCart extends CartState {}

class LoadedCart extends CartState {
  final List<CartEntity> carts;

  const LoadedCart({required this.carts});
}

class ErrorGetCart extends CartState {
  final String message;

  const ErrorGetCart({required this.message});
}

class OfflineGetCartState extends CartState {
  final String message;

  const OfflineGetCartState({required this.message});
}
