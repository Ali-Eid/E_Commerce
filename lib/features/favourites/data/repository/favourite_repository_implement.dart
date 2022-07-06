import '../../../../core/network/network_connection.dart';

import '../../../../core/constants.dart';
import '../datasources/local_data_source.dart';

import '../../../../core/error/failures/failures.dart';
import '../datasources/remote_data_source.dart';
import '../../domain/entities/product_favourite_entity.dart';
import '../../domain/repository/favourite_repository.dart';
import 'package:dartz/dartz.dart';

class FavouriteRepositoryImplement implements FavouriteRepository {
  final RemoteDataSource remoteDataSource;
  final LocalFavouriteDataSource localDataSource;
  final NetworkConnection networkConnection;

  FavouriteRepositoryImplement(
      this.remoteDataSource, this.localDataSource, this.networkConnection);
  @override
  Future<Either<Failure, ProductFavouriteEntities>> addFavourite(
      String productid) async {
    if (await networkConnection.isConnected) {
      try {
        lang = await localDataSource.getcachedLang();
        final remote = await remoteDataSource.addFavourite(productid);
        return right(remote);
      } catch (e) {
        print(e.toString());
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductFavouriteEntities>>> getFavourite() async {
    if (await networkConnection.isConnected) {
      try {
        lang = await localDataSource.getcachedLang();
        final remote = await remoteDataSource.getFavourite();
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
