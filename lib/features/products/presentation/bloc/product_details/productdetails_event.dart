part of 'productdetails_bloc.dart';

abstract class ProductdetailsEvent extends Equatable {
  const ProductdetailsEvent();

  @override
  List<Object> get props => [];
}

class getDetailsProductEvent extends ProductdetailsEvent {
  final int id;

  const getDetailsProductEvent({required this.id});
}
