import '../../../../core/error/failures/failures.dart';
import '../entities/banners_entities.dart';
import 'package:dartz/dartz.dart';

abstract class RepositoryImgBanner {
  Future<Either<Failure, BannersEntities>> getImgBanners();
}
