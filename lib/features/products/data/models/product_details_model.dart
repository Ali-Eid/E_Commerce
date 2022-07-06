import '../../domain/entities/product_details_entities.dart';

class ProductDetailsModel extends ProductDetailsEntities {
  ProductDetailsModel({
    required var id,
    required var price,
    required var oldPrice,
    required var discount,
    required String image,
    required String name,
    required String description,
    required var inFavorites,
    required var inCart,
    required var images,
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
          images: images,
        );
  factory ProductDetailsModel.fromjson(Map<String, dynamic> json) {
    return ProductDetailsModel(
        id: json['id'],
        price: json['price'],
        oldPrice: json['old_price'],
        discount: json['discount'],
        image: json['image'],
        name: json['name'],
        description: json['description'],
        inFavorites: json['inFavorites'],
        inCart: json['inCart'],
        images: json['images']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'old_price': oldPrice,
      'discount': discount,
      'image': image,
      'name': name,
      'description': description,
      'inFavorites': inFavorites,
      'inCart': inCart,
      'images': images,
    };
  }
}
