import 'package:equatable/equatable.dart';

class ProductFavouriteEntities extends Equatable {
  var id;
  var name;
  var description;
  var price;
  var oldPrice;
  var discount;
  final String? image;

  ProductFavouriteEntities({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
  });

  @override
  List<Object?> get props =>
      [id, price, oldPrice, discount, image, name, description];
}
