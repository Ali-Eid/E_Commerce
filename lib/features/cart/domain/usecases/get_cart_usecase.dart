import '../../../../core/error/failures/failures.dart';
import '../entities/cart_entitiy.dart';
import '../repository/cart_repository.dart';
import 'package:dartz/dartz.dart';

class GetCartUseCase {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  Future<Either<Failure, List<CartEntity>>> call() async {
    return await repository.getCart();
  }
}
