part of 'favourite_bloc.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}

//-------------------Get All Favourites-------------
class LaodingFavouriteState extends FavouriteState {}

class LaodedFavouriteState extends FavouriteState {
  final List<ProductFavouriteEntities> favourites;

  const LaodedFavouriteState({required this.favourites});
}

class ErrorFavouriteState extends FavouriteState {
  final String message;

  const ErrorFavouriteState({required this.message});
}

class OfflineFaouriteState extends FavouriteState {
  final String message;

  const OfflineFaouriteState({required this.message});
}
