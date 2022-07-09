import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import '../../../../cart/presentation/bloc/add_delete_cart/add_delete_cart_bloc.dart';
import '../../../../cart/presentation/widgets/cart_icon_widget.dart';
import '../../../../favourites/presentation/bloc/add_delete_favourite/add_delete_favourite_bloc.dart';
import '../../../../favourites/presentation/bloc/favourite/favourite_bloc.dart';
import '../../../../../core/app_theme.dart';
import '../../../../../core/constants.dart';
import '../../../../favourites/presentation/widgets/favourite_icon_widget.dart';
import '../../../data/models/products_model.dart';
import '../../../domain/entities/products_entities.dart';
import '../../bloc/product_details/productdetails_bloc.dart';
import '../../pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductEntities model;
  const ProductItemWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        BlocProvider.of<ProductdetailsBloc>(context)
            .add(getDetailsProductEvent(id: model.id!));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const ProductsDetailsPage(),
          ),
        );
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 2.h,
        ),
        Stack(
          alignment: Alignment.topRight,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  // height: 65.h,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: CachedNetworkImage(
                    width: double.infinity,
                    height: 77.h,
                    imageUrl: model.image!,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                if (model.price != model.oldPrice)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    color: primaryColor,
                    child: Text(
                      AppLocalizations.of(context)!.discount,
                      style: TextStyle(fontSize: 10.sp, color: Colors.white),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: BlocBuilder<FavouriteBloc, FavouriteState>(
                builder: (context, state) {
                  return BlocBuilder<AddDeleteFavouriteBloc,
                      AddDeleteFavouriteState>(
                    builder: (context, state) {
                      return FavouriteIconWidget(
                        product: model,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              model.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.sp, height: 1.1),
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
                      '${model.price!.round()} EGP',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    if (model.price != model.oldPrice)
                      Expanded(
                        child: Text(
                          '${model.oldPrice!.round()}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
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
