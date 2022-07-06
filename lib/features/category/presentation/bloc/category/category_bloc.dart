import 'package:bloc/bloc.dart';
import 'package:clean_architicture_ecommerce/core/error/failures/failures.dart';
import '../../../domain/entities/category_details_entitites.dart';
import '../../../domain/entities/category_entities.dart';
import '../../../domain/usecases/get_category_details.dart';
import '../../../domain/usecases/get_category_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoryUseCase getCategory;
  // final GetCategoryDetailsUseCase getCategoryDetails;
  CategoryBloc({
    required this.getCategory,
    // required this.getCategoryDetails,
  }) : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is GetCategoryEvent) {
        emit(LoadingCategoyState());
        final failureOrCategory = await getCategory();
        failureOrCategory.fold((failure) {
          // emit(ErrorGetCategoyState(message: failure.toString()));
          emit(_mapFailureToState(failure));
        }, (category) {
          emit(LoadedCategoyState(category: category));
        });
      }
    });
  }

  CategoryState _mapFailureToState(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return const ErrorGetCategoyState(
            message: 'Server Error Please Try again Later . ');
      case OfflineFailure:
        return const OfflineCategoyState(
            message: 'No internet Connection , please check your connection .');

      default:
        return const ErrorGetCategoyState(
            message: 'Unexpected Error , please try again later .');
    }
  }
}
