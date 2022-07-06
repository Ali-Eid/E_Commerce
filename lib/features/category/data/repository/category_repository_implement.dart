import 'package:clean_architicture_ecommerce/core/network/network_connection.dart';

import '../../../../core/constants.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../../domain/entities/category_details_entitites.dart';
import '../../domain/entities/category_entities.dart';
import '../../../../core/error/failures/failures.dart';
import '../../domain/repository/category_repository.dart';
import '../../../favourites/data/datasources/remote_data_source.dart';
import 'package:dartz/dartz.dart';

class CategoryRepoImplement implements CategoryRepository {
  final RemoteCategoryDataSource remoteDataSource;
  final LocalCategoryDataSource localDataSource;
  final NetworkConnection networkConnection;

  CategoryRepoImplement(
    this.remoteDataSource,
    this.localDataSource,
    this.networkConnection,
  );

  @override
  Future<Either<Failure, List<CategoryEntities>>> getCategory() async {
    if (await networkConnection.isConnected) {
      try {
        lang = await localDataSource.getcachedLang();
        final remote = await remoteDataSource.getCategory();
        return right(remote);
      } catch (e) {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<CategoryDetailsEntities>>> getDetailsCategory(
      int id) async {
    if (await networkConnection.isConnected) {
      try {
        final remote = await remoteDataSource.getDetailsCategory(id);
        return right(remote);
      } catch (e) {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
