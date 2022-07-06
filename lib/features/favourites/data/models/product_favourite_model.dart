import '../../domain/entities/product_favourite_entity.dart';

class FavModel {
  int? id;
  ProductFavouriteModel? product;

  FavModel(this.id, this.product);

  FavModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null
        ? ProductFavouriteModel.fromjson(json['product'])
        : null;
  }
}

class ProductFavouriteModel extends ProductFavouriteEntities {
  ProductFavouriteModel({
    required var id,
    required var name,
    required var description,
    required var price,
    required var oldPrice,
    required var discount,
    required var image,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          discount: discount,
          image: image,
          oldPrice: oldPrice,
        );
  factory ProductFavouriteModel.fromjson(Map<String, dynamic> json) {
    return ProductFavouriteModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      discount: json['discount'],
      image: json['image'],
      price: json['price'],
      oldPrice: json['old_price'],
    );
  }
  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'description': description,
      'name': name,
      'price': price,
      'discount': discount,
      'image': image,
      'old_price': oldPrice,
    };
  }
}
