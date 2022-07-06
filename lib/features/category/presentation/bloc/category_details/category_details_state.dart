part of 'category_details_bloc.dart';

abstract class CategoryDetailsState extends Equatable {
  const CategoryDetailsState();

  @override
  List<Object> get props => [];
}

class CategoryDetailsInitial extends CategoryDetailsState {}

class LoadingCategoyDetailsState extends CategoryDetailsState {}

class LoadedCategoyDetailsState extends CategoryDetailsState {
  final List<CategoryDetailsEntities> category;

  const LoadedCategoyDetailsState({required this.category});
}

class ErrorGetDetailsCategoyState extends CategoryDetailsState {
  final String message;

  const ErrorGetDetailsCategoyState({required this.message});
}
