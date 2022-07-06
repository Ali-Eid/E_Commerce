import '../../../../core/error/failures/failures.dart';
import '../entities/category_details_entitites.dart';
import '../entities/category_entities.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntities>>> getCategory();
  Future<Either<Failure, List<CategoryDetailsEntities>>> getDetailsCategory(
      int id);
}
