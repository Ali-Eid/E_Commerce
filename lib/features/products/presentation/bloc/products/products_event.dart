part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class getAllProductsEvent extends ProductsEvent {}

class refreshAllProductsEvent extends ProductsEvent {}
