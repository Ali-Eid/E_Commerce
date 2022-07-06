import '../../../../core/error/failures/failures.dart';
import '../entities/product_details_entities.dart';
import '../entities/products_entities.dart';
import '../repository/products_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductDetailsUseCase {
  final RepositoryProducts repository;

  GetProductDetailsUseCase(this.repository);
  Future<Either<Failure, ProductDetailsEntities>> call(int productid) async {
    return await repository.getproductDetails(productid);
  }
}
