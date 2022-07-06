import 'package:dartz/dartz.dart';

import '../../../../core/error/failures/failures.dart';
import '../entities/auth_entities.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntities>> login(String username, String password);
  Future<Either<Failure, AuthEntities>> signup(
    String name,
    String email,
    String password,
    String phone,
  );
}
