part of 'productdetails_bloc.dart';

abstract class ProductdetailsState extends Equatable {
  const ProductdetailsState();

  @override
  List<Object> get props => [];
}

class ProductdetailsInitial extends ProductdetailsState {}

class LoadingDetailsProductState extends ProductdetailsState {}

class SuccessDetailsProductState extends ProductdetailsState {
  final ProductDetailsEntities product;

  const SuccessDetailsProductState({required this.product});
}

class ErrorDetailsProductState extends ProductdetailsState {
  final String message;

  const ErrorDetailsProductState({required this.message});
}
