import '../../../../core/error/failures/failures.dart';
import '../entities/banners_entities.dart';
import '../repository/banners_repository.dart';
import '../../../products/domain/repository/products_repository.dart';
import 'package:dartz/dartz.dart';

class GetImagBannersUseCase {
  final RepositoryImgBanner repository;

  GetImagBannersUseCase(this.repository);

  Future<Either<Failure, BannersEntities>> call() async {
    return await repository.getImgBanners();
  }
}
