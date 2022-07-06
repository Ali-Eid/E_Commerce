import 'package:clean_architicture_ecommerce/core/constants.dart';
import 'package:clean_architicture_ecommerce/core/widget/no_intenet_widget.dart';
import 'package:clean_architicture_ecommerce/features/favourites/presentation/bloc/favourite/favourite_bloc.dart';
import 'package:clean_architicture_ecommerce/features/favourites/presentation/widgets/favourites_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        if (state is LaodingFavouriteState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorFavouriteState) {
          return RefreshIndicator(
            onRefresh: () async {
              return BlocProvider.of<FavouriteBloc>(context)
                  .add(GetAllFavouriteProductEvent());
            },
            child: ErrorConnectionWidget(
                text: state.message, pathImg: 'assets/images/serverError.json'),
          );
        } else if (state is OfflineFaouriteState) {
          return RefreshIndicator(
            onRefresh: () async {
              return BlocProvider.of<FavouriteBloc>(context)
                  .add(GetAllFavouriteProductEvent());
            },
            child: ErrorConnectionWidget(
                text: state.message, pathImg: 'assets/images/nointernet.json'),
          );
        } else if (state is LaodedFavouriteState) {
          return FavouritesWidget(
            favourite: inFav,
          );
        }
        return FavouritesWidget(
          favourite: inFav,
        );
      },
    );
  }
}
