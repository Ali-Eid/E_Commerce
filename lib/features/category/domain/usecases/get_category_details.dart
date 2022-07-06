import '../../../../core/error/failures/failures.dart';
import '../entities/category_details_entitites.dart';
import '../repository/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategoryDetailsUseCase {
  final CategoryRepository repository;

  GetCategoryDetailsUseCase(this.repository);

  Future<Either<Failure, List<CategoryDetailsEntities>>> call(
      int categoryid) async {
    return await repository.getDetailsCategory(categoryid);
  }
}
