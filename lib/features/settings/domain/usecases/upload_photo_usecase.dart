import 'package:clean_architicture_ecommerce/core/error/failures/failures.dart';
import 'package:clean_architicture_ecommerce/features/settings/domain/entities/profile_entity.dart';
import 'package:clean_architicture_ecommerce/features/settings/domain/repository/setting_repositroy.dart';
import 'package:dartz/dartz.dart';

class UploadPhotoUseCase {
  final SettingRepository repository;

  UploadPhotoUseCase(this.repository);
  Future<Either<Failure, ProfileEntitiy>> call(
      {required ProfileEntitiy profile}) async {
    return await repository.uploadprofilePhoto(profile: profile);
  }
}
