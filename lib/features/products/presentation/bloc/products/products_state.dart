part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

//---------------------Get All Product----------------------
class LoadingProductsState extends ProductsState {}

class SuccessGetAllProductsState extends ProductsState {
  final List<ProductEntities> products;

  const SuccessGetAllProductsState({required this.products});
}

class ErrorGetAllProductsState extends ProductsState {
  final String message;

  const ErrorGetAllProductsState({required this.message});
}

class OfflineProductsState extends ProductsState {
  final String message;

  const OfflineProductsState({required this.message});
}

//---------------------Refresh all Product----------------------
class LoadingRefreshDetailsProductState extends ProductsState {}
