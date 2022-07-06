import '../../../../core/error/failures/failures.dart';
import '../entities/category_entities.dart';
import '../repository/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategoryUseCase {
  final CategoryRepository repository;

  GetCategoryUseCase(this.repository);
  Future<Either<Failure, List<CategoryEntities>>> call() async {
    return await repository.getCategory();
  }
}
