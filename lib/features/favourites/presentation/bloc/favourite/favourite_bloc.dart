import 'package:bloc/bloc.dart';
import 'package:clean_architicture_ecommerce/core/error/failures/failures.dart';
import '../../../../../core/constants.dart';
import '../../../domain/entities/product_favourite_entity.dart';
import '../../../domain/usecases/add_favourite.dart';
import '../../../domain/usecases/get_favourite.dart';
import 'package:equatable/equatable.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final GetAllFavouriteUseCase getAllFavourite;

  FavouriteBloc({
    required this.getAllFavourite,
  }) : super(FavouriteInitial()) {
    on<FavouriteEvent>((event, emit) async {
      if (event is GetAllFavouriteProductEvent) {
        inFav = [];
        emit(LaodingFavouriteState());
        final failureOrFavourites = await getAllFavourite();
        failureOrFavourites.fold((failure) {
          emit(_mapFailureToState(failure));
        }, (favourites) {
          for (var element in favourites) {
            inFav.add(element);
          }
          emit(
            LaodedFavouriteState(favourites: favourites),
          );
        });
      }
    });
  }
  FavouriteState _mapFailureToState(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return const ErrorFavouriteState(
            message: 'Server Error Please Try again Later . ');
      case OfflineFailure:
        return const OfflineFaouriteState(
            message: 'No internet Connection , please check your connection .');

      default:
        return const ErrorFavouriteState(
            message: 'Unexpected Error , please try again later .');
    }
  }
}
