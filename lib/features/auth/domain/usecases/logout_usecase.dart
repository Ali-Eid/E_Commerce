import 'package:clean_architicture_ecommerce/core/error/failures/failures.dart';
import 'package:clean_architicture_ecommerce/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);
  Future<Either<Failure, String>> call() async {
    return await repository.logout();
  }
}
