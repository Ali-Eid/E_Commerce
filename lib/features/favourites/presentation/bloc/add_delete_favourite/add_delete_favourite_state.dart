part of 'add_delete_favourite_bloc.dart';

abstract class AddDeleteFavouriteState extends Equatable {
  const AddDeleteFavouriteState();

  @override
  List<Object> get props => [];
}

class AddDeleteFavouriteInitial extends AddDeleteFavouriteState {}
//-------------------Add Favourite-------------

class AddedFavouriteProduct extends AddDeleteFavouriteState {}

class SuccessAddedFavouriteProduct extends AddDeleteFavouriteState {
  final ProductFavouriteEntities addedFavourite;

  const SuccessAddedFavouriteProduct({
    required this.addedFavourite,
  });
}

class ErrorFavouriteProduct extends AddDeleteFavouriteState {
  final String message;

  const ErrorFavouriteProduct({required this.message});
}

//-------------------Delete Favourite-------------

class changedeleteFavouriteProduct extends AddDeleteFavouriteState {}

class DeletedFavouriteProduct extends AddDeleteFavouriteState {}

class SuccessDeletedFavouriteProduct extends AddDeleteFavouriteState {
  final ProductFavouriteEntities addedFavourite;

  const SuccessDeletedFavouriteProduct({
    required this.addedFavourite,
  });
}

class ErrorDeletedFavouriteProduct extends AddDeleteFavouriteState {
  final String message;

  const ErrorDeletedFavouriteProduct({required this.message});
}
