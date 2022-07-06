import '../bloc/add_delete_favourite/add_delete_favourite_bloc.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/constants.dart';
import '../../domain/entities/product_favourite_entity.dart';
import '../bloc/favourite/favourite_bloc.dart';
import '../../../products/domain/entities/products_entities.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteIconWidget extends StatefulWidget {
  // final int productid;
  final ProductEntities product;
  const FavouriteIconWidget({Key? key, required this.product})
      : super(key: key);

  @override
  State<FavouriteIconWidget> createState() => _FavouriteIconWidget();
}

class _FavouriteIconWidget extends State<FavouriteIconWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            // print('product id is ${widget.product.id}');
            setState(() {
              if (isFav[widget.product.id]) {
                BlocProvider.of<AddDeleteFavouriteBloc>(context).add(
                  deletedFavouriteProductEvent(
                    product: ProductFavouriteEntities(
                      description: widget.product.name!,
                      name: widget.product.name!,
                      id: widget.product.id!,
                      price: widget.product.price!,
                      oldPrice: widget.product.oldPrice!,
                      discount: widget.product.discount!,
                      image: widget.product.image!,
                    ),
                  ),
                );
              } else {
                BlocProvider.of<AddDeleteFavouriteBloc>(context).add(
                  addFavouriteProductEvent(
                    product: ProductFavouriteEntities(
                      description: widget.product.name!,
                      name: widget.product.name!,
                      id: widget.product.id!,
                      price: widget.product.price!,
                      oldPrice: widget.product.oldPrice!,
                      discount: widget.product.discount!,
                      image: widget.product.image!,
                    ),
                  ),
                );
              }
            });
          },
          icon: isFav[widget.product.id]
              // model.inFavorites!
              ? const Icon(
                  Icons.favorite,
                  color: primaryColor,
                )
              : const Icon(
                  Icons.favorite_border,
                  color: primaryColor,
                ),
        );
      },
    );
  }
}
