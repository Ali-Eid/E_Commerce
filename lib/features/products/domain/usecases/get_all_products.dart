import 'package:dartz/dartz.dart';

import '../../../../core/error/failures/failures.dart';
import '../entities/products_entities.dart';
import '../repository/products_repository.dart';

class GetAllProductsUseCase {
  final RepositoryProducts repository;

  GetAllProductsUseCase(this.repository);
  Future<Either<Failure, List<ProductEntities>>> call() async {
    return await repository.getAllProducts();
  }
}
