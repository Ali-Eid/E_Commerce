import '../../../../core/error/failures/failures.dart';
import '../entities/product_favourite_entity.dart';
import '../repository/favourite_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllFavouriteUseCase {
  final FavouriteRepository repository;

  GetAllFavouriteUseCase(this.repository);
  Future<Either<Failure, List<ProductFavouriteEntities>>> call() async {
    return await repository.getFavourite();
  }
}
