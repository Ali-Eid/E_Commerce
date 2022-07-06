import '../../../../core/error/failures/failures.dart';
import '../entities/profile_entity.dart';
import '../repository/setting_repositroy.dart';
import 'package:dartz/dartz.dart';

class GetProfileUseCase {
  final SettingRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<Failure, ProfileEntitiy>> call() async {
    return await repository.getProfile();
  }
}
