import '../../../../core/error/failures/failures.dart';
import '../entities/cart_entitiy.dart';
import '../repository/cart_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateQuantityUseCase {
  final CartRepository repository;

  UpdateQuantityUseCase(this.repository);
  Future<Either<Failure, CartEntity>> call(
      String cartid, String quantity) async {
    return await repository.updatequantity(cartid, quantity);
  }
}
