part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryEvent extends CategoryEvent {}

// class GetDetailsCategoryEvent extends CategoryEvent {
//   final int id;

//   const GetDetailsCategoryEvent(this.id);
//   @override
//   List<Object> get props => [id];
// }
