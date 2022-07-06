import '../../../../core/error/failures/failures.dart';
import '../entities/profile_entity.dart';
import '../repository/setting_repositroy.dart';
import 'package:dartz/dartz.dart';

class UpdateProfileUseCase {
  final SettingRepository repository;

  UpdateProfileUseCase(this.repository);
  Future<Either<Failure, ProfileEntitiy>> call({required ProfileEntitiy profile
      // required String name,
      // required String email,
      // required String phone,
      }) async {
    return await repository.updateProfile(profile: profile);
  }
}
