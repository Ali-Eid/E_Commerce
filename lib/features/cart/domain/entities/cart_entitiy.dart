import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final int id;
  var quantity;
  final CartProduct product;

  CartEntity({
    required this.id,
    required this.quantity,
    required this.product,
  });
  @override
  List<Object?> get props => [id, quantity, product];
}

class CartProduct {
  final int id;
  final String? name;
  final String? description;
  var price;
  var oldPrice;
  var discount;
  final String? image;

  CartProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
  });
  factory CartProduct.fromjson(Map<String, dynamic> json) {
    return CartProduct(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        oldPrice: json['old_price'],
        discount: json['discount'],
        image: json['image']);
  }
}
