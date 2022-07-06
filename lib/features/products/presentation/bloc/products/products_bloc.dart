import 'package:bloc/bloc.dart';
import 'package:clean_architicture_ecommerce/core/error/failures/failures.dart';
import '../../../../../core/constants.dart';
import '../../../domain/entities/products_entities.dart';
import '../../../domain/usecases/get_all_products.dart';
import '../../../domain/usecases/get_products_details.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetAllProductsUseCase getAllProducts;
  final GetProductDetailsUseCase getProductDetails;

  ProductsBloc({
    required this.getAllProducts,
    required this.getProductDetails,
  }) : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) async {
      if (event is getAllProductsEvent) {
        emit(LoadingProductsState());
        final failureOrProducts = await getAllProducts();
        failureOrProducts.fold((failure) {
          emit(_mapFailureToState(failure));
        }, (products) {
          emit(SuccessGetAllProductsState(products: products));
        });
      }
      if (event is refreshAllProductsEvent) {
        emit(LoadingRefreshDetailsProductState());
        final failureOrProducts = await getAllProducts();

        failureOrProducts.fold((failure) {
          emit(_mapFailureToState(failure));
        }, (products) {
          emit(SuccessGetAllProductsState(products: products));
        });
      }
    });
  }
  ProductsState _mapFailureToState(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return const ErrorGetAllProductsState(
            message: 'Server Error Please Try again Later . ');
      case OfflineFailure:
        return const OfflineProductsState(
            message: 'No internet Connection , please check your connection .');

      default:
        return const ErrorGetAllProductsState(
            message: 'Unexpected Error , please try again later .');
    }
  }
}
