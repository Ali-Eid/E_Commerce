import '../../../../core/error/failures/failures.dart';
import '../entities/product_favourite_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FavouriteRepository {
  Future<Either<Failure, ProductFavouriteEntities>> addFavourite(
      String productid);
  Future<Either<Failure, List<ProductFavouriteEntities>>> getFavourite();
}
