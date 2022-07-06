// import 'package:clean_architicture_ecommerce/features/products/domain/entities/products_entities.dart';

// class ProductsModel extends ProductEntities {
//   const ProductsModel({
//     int? id,
//     int? price,
//     int? oldPrice,
//     int? discount,
//     String? image,
//     String? name,
//     String? description,
//     List<String>? images,
//     bool? inFavorites,
//     bool? inCart,
//   }) : super(
//           id: id,
//           price: price,
//           oldPrice: oldPrice,
//           discount: discount,
//           description: description,
//           image: image,
//           images: images,
//           name: name,
//           inFavorites: inFavorites,
//           inCart: inCart,
//         );

//   factory ProductsModel.fromjson(Map<String, dynamic> json) {
//     return ProductsModel(
//       id: json['id'],
//       price: json['price'],
//       oldPrice: json['oldPrice'],
//       name: json['name'],
//       description: json['description'],
//       discount: json['discount'],
//       image: json['image'],
//       images: json['images'],
//       inCart: json['inCart'],
//       inFavorites: json['inFavorites'],
//     );
//   }

//   Map<String, dynamic> tojson() {
//     return {
//       'id': id,
//       'price': price,
//       'oldPrice': oldPrice,
//       'name': name,
//       'description': description,
//       'discount': discount,
//       'image': image,
//       'images': images,
//       'inCart': inCart,
//       'inFavorites': inFavorites,
//     };
//   }
// }
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
  // List<DataProductEntities>? data;

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
  // ProductsModel({this.data});

  // ProductsModel.fromJson(Map<String, dynamic> json) {
  //   if (json['data'] != null) {
  //     data = <DataProductEntities>[];
  //     json['data'].forEach((v) {
  //       data!.add(DataProductEntities.fromJson(v));
  //     });
  //   }
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }


// class DataProductEntities {
//   int? id;
//   var price;
//   var oldPrice;
//   var discount;
//   String? image;
//   String? name;
//   String? description;
//   List<String>? images;
//   bool? inFavorites;
//   bool? inCart;

//   DataProductEntities(
//       {this.id,
//       this.price,
//       this.oldPrice,
//       this.discount,
//       this.image,
//       this.name,
//       this.description,
//       this.images,
//       this.inFavorites,
//       this.inCart});

//   DataProductEntities.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//     images = json['images'].cast<String>();
//     inFavorites = json['in_favorites'];
//     inCart = json['in_cart'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['price'] = price;
//     data['old_price'] = oldPrice;
//     data['discount'] = discount;
//     data['image'] = image;
//     data['name'] = name;
//     data['description'] = description;
//     data['images'] = images;
//     data['in_favorites'] = inFavorites;
//     data['in_cart'] = inCart;
//     return data;
//   }
// }
