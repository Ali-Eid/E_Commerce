import 'package:equatable/equatable.dart';

class CategoryEntities extends Equatable {
  final int id;
  final String name;
  final String image;

  const CategoryEntities(this.id, this.name, this.image);
  @override
  List<Object?> get props => [id, name, image];
}
