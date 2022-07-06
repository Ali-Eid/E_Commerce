import 'package:clean_architicture_ecommerce/features/products/domain/entities/products_entities.dart';
import 'package:flutter/foundation.dart';

class ProductsModel extends ProductEntities {
  ProductsModel({
    required int? id,
    required var price,
    required var oldPrice,
    required var discount,
    required String? image,
    required String? name,
    required String? description,
    required List<dynamic>? images,
    required bool? inFavorites,
    required bool? inCart,
  }) : super(
          id: id,
          price: price,
          oldPrice: oldPrice,
          discount: discount,
          image: image,
          images: images,
          name: name,
          description: description,
          inCart: inCart,
          inFavorites: inFavorites,
        );
  @override
  factory ProductsModel.fromjson(Map<String, dynamic> json) {
    return ProductsModel(
        id: json['id'],
        price: json['price'],
        oldPrice: json['old_price'],
        discount: json['discount'],
        image: json['image'],
        name: json['name'],
        description: json['description'],
        images: json['images'],
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
      'images': images,
      'name': name,
      'description': description,
      'in_favorites': inFavorites,
      'in_cart': inCart
    };
  }
}
