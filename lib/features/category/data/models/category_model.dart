import '../../domain/entities/category_entities.dart';

class CategoryModel extends CategoryEntities {
  const CategoryModel(int id, String name, String image)
      : super(id, name, image);

  factory CategoryModel.fromjson(Map<String, dynamic> json) {
    return CategoryModel(
      json['id'],
      json['name'],
      json['image'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
