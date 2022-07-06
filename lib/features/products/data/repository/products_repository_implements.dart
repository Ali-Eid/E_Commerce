import 'package:clean_architicture_ecommerce/core/network/network_connection.dart';

import '../../../../core/constants.dart';
import '../datasources/local_data_source.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures/failures.dart';
import '../../domain/entities/product_details_entities.dart';
import '../../domain/entities/products_entities.dart';
import '../../domain/repository/products_repository.dart';
import '../datasources/remote_products_datasource.dart';

class ProductsRepositoryImplements implements RepositoryProducts {
  final RemoteDatasource remoteDatasource;
  final LocalProductDataSource localDatasource;
  final NetworkConnection networkConnection;

  ProductsRepositoryImplements({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.networkConnection,
  });
  @override
  Future<Either<Failure, List<ProductEntities>>> getAllProducts() async {
    if (await networkConnection.isConnected) {
      try {
        lang = await localDatasource.getcachedLang();
        final remote = await remoteDatasource.getAllProducts();
        return right(remote);
      } catch (e) {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, ProductDetailsEntities>> getproductDetails(
      int productid) async {
    if (await networkConnection.isConnected) {
      try {
        final remote = await remoteDatasource.getProductDetails(productid);
        return right(remote);
      } catch (e) {
        print(e.toString());
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
