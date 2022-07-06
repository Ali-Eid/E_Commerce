import '../../../../core/error/failures/failures.dart';
import '../entities/product_details_entities.dart';
import '../entities/products_entities.dart';
import 'package:dartz/dartz.dart';

abstract class RepositoryProducts {
  Future<Either<Failure, List<ProductEntities>>> getAllProducts();
  Future<Either<Failure, ProductDetailsEntities>> getproductDetails(
    int productid,
  );
}
