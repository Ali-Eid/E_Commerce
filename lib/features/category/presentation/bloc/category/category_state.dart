part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

//--------------Get Category----------------

class LoadingCategoyState extends CategoryState {}

class LoadedCategoyState extends CategoryState {
  final List<CategoryEntities> category;

  const LoadedCategoyState({required this.category});
}

class ErrorGetCategoyState extends CategoryState {
  final String message;

  const ErrorGetCategoyState({required this.message});
}

class OfflineCategoyState extends CategoryState {
  final String message;

  const OfflineCategoyState({required this.message});
}

//-----------------Category Details ---------
// class LoadingCategoyDetailsState extends CategoryState {}

// class LoadedCategoyDetailsState extends CategoryState {
//   final List<CategoryDetailsEntities> category;

//   const LoadedCategoyDetailsState({required this.category});
// }

// class ErrorGetDetailsCategoyState extends CategoryState {
//   final String message;

//   const ErrorGetDetailsCategoyState({required this.message});
// }
