import '../datasources/remote_products_datasource.dart';
import '../../domain/entities/banners_entities.dart';
import '../../domain/repository/banners_repository.dart';
import '../../../products/data/datasources/remote_products_datasource.dart';
import '../../../products/domain/entities/products_entities.dart';
import '../../../../core/error/failures/failures.dart';
import '../../../products/domain/repository/products_repository.dart';
import 'package:dartz/dartz.dart';

class BannersRepositoryImplements implements RepositoryImgBanner {
  final RemoteBannersDatasource remoteDatasource;

  BannersRepositoryImplements({required this.remoteDatasource});

  @override
  Future<Either<Failure, BannersEntities>> getImgBanners() async {
    try {
      final remote = await remoteDatasource.getBannersImg();
      return right(remote);
    } catch (e) {
      return left(ServerFailure());
    }
  }
}
