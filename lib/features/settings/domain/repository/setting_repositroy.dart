import '../../../../core/error/failures/failures.dart';
import '../entities/profile_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SettingRepository {
  Future<Either<Failure, ProfileEntitiy>> getProfile();
  Future<Either<Failure, ProfileEntitiy>> updateProfile(
      {required ProfileEntitiy profile});
  Future<Either<Failure, ProfileEntitiy>> uploadprofilePhoto(
      {required ProfileEntitiy profile});

  String setLanguage(String locale);
}
