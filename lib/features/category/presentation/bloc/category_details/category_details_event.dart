part of 'category_details_bloc.dart';

abstract class CategoryDetailsEvent extends Equatable {
  const CategoryDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetDetailsCategoryEvent extends CategoryDetailsEvent {
  final int id;

  const GetDetailsCategoryEvent(this.id);
  @override
  List<Object> get props => [id];
}
