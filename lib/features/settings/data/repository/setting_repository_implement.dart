import 'package:clean_architicture_ecommerce/core/network/network_connection.dart';

import '../../../../core/error/exceptions/exceptions.dart';
import '../datasource/local_data_source.dart';
import '../datasource/remote_data_source.dart';
import '../../domain/entities/profile_entity.dart';
import '../../../../core/error/failures/failures.dart';
import '../../domain/repository/setting_repositroy.dart';
import 'package:dartz/dartz.dart';

class SettingRepositoryImpl implements SettingRepository {
  final RemoteSettingDataSource remoteSettingDataSource;
  final SettingLocalDataSource localSettingDataSource;
  final NetworkConnection networkConnection;

  SettingRepositoryImpl(this.remoteSettingDataSource,
      this.localSettingDataSource, this.networkConnection);
  @override
  Future<Either<Failure, ProfileEntitiy>> getProfile() async {
    if (await networkConnection.isConnected) {
      try {
        final remote = await remoteSettingDataSource.getProfile();
        return right(remote);
      } catch (e) {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  String setLanguage(String lang) {
    localSettingDataSource.cachedLang(lang);
    return '';
  }

  @override
  Future<Either<Failure, ProfileEntitiy>> updateProfile(
      {required ProfileEntitiy profile}) async {
    if (await networkConnection.isConnected) {
      try {
        final remote =
            await remoteSettingDataSource.updateProfile(profile: profile);
        return right(remote);
      } catch (e) {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
