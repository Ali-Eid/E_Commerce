part of 'add_delete_favourite_bloc.dart';

abstract class AddDeleteFavouriteEvent extends Equatable {
  const AddDeleteFavouriteEvent();

  @override
  List<Object> get props => [];
}

class addFavouriteProductEvent extends AddDeleteFavouriteEvent {
  final ProductFavouriteEntities product;

  const addFavouriteProductEvent({required this.product});
  @override
  List<Object> get props => [product];
}

class deletedFavouriteProductEvent extends AddDeleteFavouriteEvent {
  final ProductFavouriteEntities product;

  const deletedFavouriteProductEvent({required this.product});
  @override
  List<Object> get props => [product];
}
