import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../core/app_theme.dart';
import '../../../../cart/presentation/bloc/add_delete_cart/add_delete_cart_bloc.dart';
import '../../../../cart/presentation/bloc/cart/cart_bloc.dart';
import '../../../../cart/presentation/widgets/cart_icon_widget.dart';
import '../../../domain/entities/category_details_entitites.dart';
import '../../../../favourites/presentation/bloc/add_delete_favourite/add_delete_favourite_bloc.dart';
import '../../../../favourites/presentation/bloc/favourite/favourite_bloc.dart';
import '../../../../favourites/presentation/widgets/favourite_icon_widget.dart';
import '../../../../products/domain/entities/products_entities.dart';
import '../../../../products/presentation/bloc/product_details/productdetails_bloc.dart';
import '../../../../products/presentation/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryDetailsItemWidget extends StatelessWidget {
  final CategoryDetailsEntities model;
  const CategoryDetailsItemWidget({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        BlocProvider.of<ProductdetailsBloc>(context)
            .add(getDetailsProductEvent(id: model.id));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const ProductsDetailsPage(),
          ),
        );
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  height: _w / 4,
                  imageUrl: model.image,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                if (model.price != model.oldPrice)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    color: primaryColor,
                    child: Text(
                      AppLocalizations.of(context)!.discount,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
              ],
            ),
            // BlocBuilder<FavouriteBloc, FavouriteState>(
            //   builder: (context, state) {
            //     return
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child:
                  BlocBuilder<AddDeleteFavouriteBloc, AddDeleteFavouriteState>(
                builder: (context, state) {
                  return FavouriteIconWidget(
                    product: ProductEntities(
                        id: model.id,
                        price: model.price,
                        oldPrice: model.oldPrice,
                        discount: model.discount,
                        image: model.image,
                        name: model.name,
                        description: model.description,
                        inFavorites: model.inFavorites,
                        inCart: model.inCart),
                  );
                },
              ),
            ),
            //   },
            // ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: _w / 60),
                child: Row(
                  children: [
                    Text(
                      '${model.price!.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: primaryColor),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    if (model.price != model.oldPrice)
                      Expanded(
                        child: Text(
                          '${model.oldPrice!.round()}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: BlocBuilder<AddDeleteCartBloc, AddDeleteCartState>(
                builder: (context, state) {
                  return CartIconWidget(
                    product: ProductEntities(
                        id: model.id,
                        price: model.price,
                        oldPrice: model.oldPrice,
                        discount: model.discount,
                        image: model.image,
                        name: model.name,
                        images: const [''],
                        description: model.description,
                        inFavorites: model.inFavorites,
                        inCart: model.inCart),
                  );
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
