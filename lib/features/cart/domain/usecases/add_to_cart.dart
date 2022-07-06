import '../../../../core/error/failures/failures.dart';
import '../entities/cart_entitiy.dart';
import '../repository/cart_repository.dart';
import 'package:dartz/dartz.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);
  Future<Either<Failure, CartEntity>> call(String productid) async {
    return await repository.addToCart(productid);
  }
}
