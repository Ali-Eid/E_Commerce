import 'package:equatable/equatable.dart';

class CategoryDetailsEntities extends Equatable {
  final int id;
  var price;
  var oldPrice;
  var discount;
  final String image;
  final String name;
  final String description;
  var inFavorites;
  var inCart;

  CategoryDetailsEntities({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.inFavorites,
    required this.inCart,
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
      ];
}
