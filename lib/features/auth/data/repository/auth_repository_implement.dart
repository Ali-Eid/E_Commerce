import 'package:clean_architicture_ecommerce/core/error/exceptions/exceptions.dart';
import 'package:clean_architicture_ecommerce/core/network/network_connection.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants.dart';
import '../../../../core/error/failures/failures.dart';
import '../../domain/entities/auth_entities.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImplements implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkConnection networkConnection;

  AuthRepositoryImplements({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
    required this.networkConnection,
  });

  @override
  Future<Either<Failure, AuthEntities>> login(
      String username, String password) async {
    if (await networkConnection.isConnected) {
      try {
        final remote = await authRemoteDataSource.login(username, password);
        authLocalDataSource.cached(remote.token);
        token = await authLocalDataSource.getcachedToken();
        return right(remote);
      } on LoginException {
        return left(LoginFailure());
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, AuthEntities>> signup(
      String name, String email, String password, String phone) async {
    if (await networkConnection.isConnected) {
      try {
        final remote =
            await authRemoteDataSource.signUp(name, email, password, phone);
        authLocalDataSource.cached(remote.token);
        token = await authLocalDataSource.getcachedToken();
        return right(remote);
      } on SignUpException {
        return left(SignUpFailure());
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      throw left(OfflineException());
    }
  }
}
