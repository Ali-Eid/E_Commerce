import '../../../../core/error/failures/failures.dart';
import '../entities/auth_entities.dart';
import '../repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthEntities>> call(
      String username, String password) async {
    return await repository.login(username, password);
  }
}
