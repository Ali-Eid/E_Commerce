import 'package:bloc/bloc.dart';
import '../../../../../core/constants.dart';
import '../../../domain/entities/product_favourite_entity.dart';
import '../../../domain/usecases/add_favourite.dart';
import 'package:equatable/equatable.dart';

part 'add_delete_favourite_event.dart';
part 'add_delete_favourite_state.dart';

class AddDeleteFavouriteBloc
    extends Bloc<AddDeleteFavouriteEvent, AddDeleteFavouriteState> {
  final AddFavouriteUseCase addFavourite;
  AddDeleteFavouriteBloc({required this.addFavourite})
      : super(AddDeleteFavouriteInitial()) {
    on<AddDeleteFavouriteEvent>((event, emit) async {
      if (event is addFavouriteProductEvent) {
        isFav[event.product.id] = !isFav[event.product.id];
        emit(AddedFavouriteProduct());
        inFav.add(
          ProductFavouriteEntities(
            description: event.product.name!,
            name: event.product.name!,
            id: event.product.id!,
            price: event.product.price!,
            oldPrice: event.product.oldPrice!,
            discount: event.product.discount!,
            image: event.product.image!,
          ),
        );
        emit(AddedFavouriteProduct());
        final failureOrFavouriteAdd =
            await addFavourite(event.product.id.toString());
        failureOrFavouriteAdd.fold((failure) {
          isFav[event.product.id] = !isFav[event.product.id];
          emit(ErrorFavouriteProduct(message: failure.toString()));
        }, (favouriteAdded) {
          emit(SuccessAddedFavouriteProduct(addedFavourite: favouriteAdded));
        });
      }
      //-----------------------------------------------------------------------------------------
      if (event is deletedFavouriteProductEvent) {
        isFav[event.product.id] = !isFav[event.product.id];
        emit(changedeleteFavouriteProduct());
        inFav.removeWhere((element) => element.id == event.product.id);
        final failureOrFavouriteAdd =
            await addFavourite(event.product.id.toString());
        failureOrFavouriteAdd.fold((failure) {
          isFav[event.product.id] = !isFav[event.product.id];
          emit(ErrorDeletedFavouriteProduct(message: failure.toString()));
        }, (favouriteAdded) {
          emit(SuccessDeletedFavouriteProduct(addedFavourite: favouriteAdded));
        });
      }
    });
  }
}
