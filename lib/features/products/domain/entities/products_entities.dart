import 'package:equatable/equatable.dart';

// class ProductEntities extends Equatable {
//   List<DataProductEntities>? data;

//   @override
//   List<Object?> get props => [data];
// }
class ProductEntities extends Equatable {
  final int? id;
  var price;
  var oldPrice;
  var discount;
  final String? image;
  final String? name;
  final String? description;
  final List<dynamic>? images;
  final bool? inFavorites;
  final bool? inCart;

  ProductEntities(
      {this.id,
      required this.price,
      required this.oldPrice,
      required this.discount,
      required this.image,
      required this.name,
      required this.description,
      this.images,
      required this.inFavorites,
      required this.inCart});

  @override
  List<Object?> get props => [
        id,
        price,
        oldPrice,
        discount,
        image,
        name,
        description,
        images,
        inFavorites,
        inCart,
      ];
}
