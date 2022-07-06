import '../../../../core/error/failures/failures.dart';
import '../entities/product_favourite_entity.dart';
import '../repository/favourite_repository.dart';
import 'package:dartz/dartz.dart';

class AddFavouriteUseCase {
  final FavouriteRepository repository;

  AddFavouriteUseCase(this.repository);
  Future<Either<Failure, ProductFavouriteEntities>> call(
      String productid) async {
    return await repository.addFavourite(productid);
  }
}
