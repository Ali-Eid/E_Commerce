import '../../domain/entities/category_details_entitites.dart';

class CategoryDetailsModel extends CategoryDetailsEntities {
  CategoryDetailsModel({
    required int id,
    required var price,
    required var oldPrice,
    required var discount,
    required String image,
    required String name,
    required String description,
    required var inFavorites,
    required var inCart,
  }) : super(
          id: id,
          name: name,
          price: price,
          oldPrice: oldPrice,
          discount: discount,
          image: image,
          description: description,
          inFavorites: inFavorites,
          inCart: inCart,
        );

  factory CategoryDetailsModel.fromjson(Map<String, dynamic> json) {
    return CategoryDetailsModel(
        id: json['id'],
        price: json['price'],
        oldPrice: json['old_price'],
        discount: json['discount'],
        image: json['image'],
        name: json['name'],
        description: json['description'],
        inFavorites: json['in_favorites'],
        inCart: json['in_cart']);
  }

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'price': price,
      'old_price': oldPrice,
      'discount': discount,
      'image': image,
      'name': name,
      'description': description,
      'in_favorites': inFavorites,
      'in_cart': inCart,
    };
  }
}
