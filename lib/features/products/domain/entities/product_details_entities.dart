import 'package:equatable/equatable.dart';

class ProductDetailsEntities extends Equatable {
  var id;
  var price;
  var oldPrice;
  var discount;
  var image;
  var name;
  var description;
  var inFavorites;
  var inCart;
  final List<dynamic> images;
  ProductDetailsEntities({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.inFavorites,
    required this.inCart,
    required this.images,
  });

  @override
  List<Object?> get props => [
        id,
        price,
        oldPrice,
        discount,
        image,
        name,
        description,
        inFavorites,
        inCart,
        images
      ];
}
