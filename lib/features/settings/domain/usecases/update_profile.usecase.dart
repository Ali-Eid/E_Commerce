import 'package:dartz/dartz.dart';

import '../../../../core/error/failures/failures.dart';
import '../entities/profile_entity.dart';
import '../repository/setting_repositroy.dart';

class UpdateProfileUseCase {
  final SettingRepository repository;

  UpdateProfileUseCase(this.repository);
  Future<Either<Failure, ProfileEntitiy>> call(
      {required ProfileEntitiy profile}) async {
    return await repository.updateProfile(profile: profile);
  }
}
