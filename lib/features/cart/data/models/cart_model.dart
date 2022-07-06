import '../../domain/entities/cart_entitiy.dart';

class CartModel extends CartEntity {
  CartModel({
    required int id,
    required var quantity,
    required CartProduct product,
  }) : super(id: id, quantity: quantity, product: product);

  factory CartModel.fromjson(Map<String, dynamic> json) {
    return CartModel(
        id: json['id'],
        quantity: json['quantity'],
        product: CartProduct.fromjson(json['product']));
  }
}
