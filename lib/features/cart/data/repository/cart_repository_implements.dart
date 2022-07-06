import '../../../../core/network/network_connection.dart';

import '../datasources/remote_data_source.dart';
import '../../domain/entities/cart_entitiy.dart';
import '../../../../core/error/failures/failures.dart';
import '../../domain/repository/cart_repository.dart';
import 'package:dartz/dartz.dart';

class CartRepositoyImplements implements CartRepository {
  final CartRemoteDataSource remoteDataSource;
  final NetworkConnection networkConnection;

  CartRepositoyImplements(this.remoteDataSource, this.networkConnection);
  @override
  Future<Either<Failure, List<CartEntity>>> getCart() async {
    if (await networkConnection.isConnected) {
      try {
        final remote = await remoteDataSource.getcart();
        return right(remote);
      } catch (e) {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, CartEntity>> addToCart(String productid) async {
    if (await networkConnection.isConnected) {
      try {
        final remote = await remoteDataSource.addTocart(productid);
        return right(remote);
      } catch (e) {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, CartEntity>> updatequantity(
      String cartid, String quantity) async {
    if (await networkConnection.isConnected) {
      try {
        final remote = await remoteDataSource.updatequantity(cartid, quantity);
        return right(remote);
      } catch (e) {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
