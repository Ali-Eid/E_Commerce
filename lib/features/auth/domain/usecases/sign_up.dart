import '../../../../core/error/failures/failures.dart';
import '../entities/auth_entities.dart';
import '../repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);
  Future<Either<Failure, AuthEntities>> call(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    return await repository.signup(
      name,
      email,
      password,
      phone,
    );
  }
}
