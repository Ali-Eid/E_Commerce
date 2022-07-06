import '../../../../core/error/failures/failures.dart';
import '../entities/cart_entitiy.dart';
import 'package:dartz/dartz.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartEntity>>> getCart();
  Future<Either<Failure, CartEntity>> addToCart(String productid);
  Future<Either<Failure, CartEntity>> updatequantity(
      String cartid, String quantity);
}
