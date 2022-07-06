import 'package:bloc/bloc.dart';
import '../../../../../core/constants.dart';
import '../../../domain/entities/product_details_entities.dart';
import '../../../domain/usecases/get_products_details.dart';
import 'package:equatable/equatable.dart';

part 'productdetails_event.dart';
part 'productdetails_state.dart';

class ProductdetailsBloc
    extends Bloc<ProductdetailsEvent, ProductdetailsState> {
  final GetProductDetailsUseCase getProductDetails;

  ProductdetailsBloc({
    required this.getProductDetails,
  }) : super(ProductdetailsInitial()) {
    on<ProductdetailsEvent>((event, emit) async {
      if (event is getDetailsProductEvent) {
        emit(LoadingDetailsProductState());
        final failureOrDetailsProd = await getProductDetails(event.id);
        failureOrDetailsProd.fold((failure) {
          emit(
            ErrorDetailsProductState(
              message: failure.toString(),
            ),
          );
        }, (productDetails) {
          emit(
            SuccessDetailsProductState(product: productDetails),
          );
        });
      }
    });
  }
}
