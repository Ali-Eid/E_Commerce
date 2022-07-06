import 'package:bloc/bloc.dart';
import '../../../domain/entities/category_details_entitites.dart';
import '../../../domain/usecases/get_category_details.dart';
import 'package:equatable/equatable.dart';

part 'category_details_event.dart';
part 'category_details_state.dart';

class CategoryDetailsBloc
    extends Bloc<CategoryDetailsEvent, CategoryDetailsState> {
  final GetCategoryDetailsUseCase getCategoryDetails;
  CategoryDetailsBloc({required this.getCategoryDetails})
      : super(CategoryDetailsInitial()) {
    on<CategoryDetailsEvent>((event, emit) async {
      if (event is GetDetailsCategoryEvent) {
        emit(LoadingCategoyDetailsState());
        final failureOrCategoryDetails = await getCategoryDetails(event.id);
        failureOrCategoryDetails.fold((l) {
          print('error bloc is ${l.toString()}');
          emit(
            ErrorGetDetailsCategoyState(
              message: l.toString(),
            ),
          );
        }, (categoryDetail) {
          emit(LoadedCategoyDetailsState(category: categoryDetail));
        });
      }
    });
  }
}
