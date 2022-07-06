import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_architicture_ecommerce/features/cart/domain/entities/cart_entitiy.dart';
import 'package:clean_architicture_ecommerce/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:easycartanimation/easycartanimation.dart';
import '../../../../../core/constants.dart';
import '../../../../cart/presentation/bloc/add_delete_cart/add_delete_cart_bloc.dart';
import '../../../../cart/presentation/widgets/cart_icon_widget.dart';
import '../../../../favourites/domain/entities/product_favourite_entity.dart';
import '../../../../favourites/presentation/bloc/add_delete_favourite/add_delete_favourite_bloc.dart';
import '../../../../favourites/presentation/widgets/favourite_icon_widget.dart';
import '../../../domain/entities/products_entities.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../core/app_theme.dart';
import '../../../domain/entities/product_details_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetailsWidget extends StatefulWidget {
  final ProductDetailsEntities productDetails;
  const ProductDetailsWidget({Key? key, required this.productDetails})
      : super(key: key);

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: FavouriteIconWidget(
              product: ProductEntities(
            id: widget.productDetails.id,
            price: widget.productDetails.price,
            oldPrice: widget.productDetails.oldPrice,
            discount: widget.productDetails.discount,
            image: widget.productDetails.image,
            name: widget.productDetails.name,
            description: widget.productDetails.description,
            images: widget.productDetails.images,
            inFavorites: widget.productDetails.inFavorites,
            inCart: widget.productDetails.inCart,
          )),
          backgroundColor: Colors.white,
          onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.0,
        elevation: 30.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: MediaQuery.of(context).size.height / 1.55,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, bottom: 20.0, top: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productDetails.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: Text(
                    '${AppLocalizations.of(context)!.about} ',
                    style: const TextStyle(
                        fontSize: 18,
                        color: primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                buildDescription(),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            '${widget.productDetails.price} EPG',
                            style: const TextStyle(
                                fontSize: 18, color: primaryColor),
                          ),
                          Text(
                            AppLocalizations.of(context)!.price,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      buildBottonCart(context)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          buildSliderImages(context),
        ],
      ),
    );
  }

  Expanded buildBottonCart(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: LinearGradient(
              colors: [
                primaryColor,
                primaryColor.withOpacity(0.2),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
        child: MaterialButton(
          onPressed: () {
            setState(() {
              setState(() {
                if (isCart[widget.productDetails.id]) {
                  BlocProvider.of<AddDeleteCartBloc>(context).add(
                    DeleteFromCartEvent(
                        product: CartEntity(
                      id: 1,
                      quantity: 1,
                      product: CartProduct(
                        description: widget.productDetails.name!,
                        name: widget.productDetails.name!,
                        id: widget.productDetails.id!,
                        price: widget.productDetails.price!,
                        oldPrice: widget.productDetails.oldPrice!,
                        discount: widget.productDetails.discount!,
                        image: widget.productDetails.image!,
                      ),
                    )),
                  );
                  BlocProvider.of<CartBloc>(context).add(GetCartEvent());
                } else {
                  BlocProvider.of<AddDeleteCartBloc>(context).add(
                    AddToCartEvent(
                        product: CartEntity(
                      id: 1,
                      quantity: 1,
                      product: CartProduct(
                        description: widget.productDetails.name!,
                        name: widget.productDetails.name!,
                        id: widget.productDetails.id!,
                        price: widget.productDetails.price!,
                        oldPrice: widget.productDetails.oldPrice!,
                        discount: widget.productDetails.discount!,
                        image: widget.productDetails.image!,
                      ),
                    )),
                  );
                  BlocProvider.of<CartBloc>(context).add(GetCartEvent());
                }
              });
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.add_to_cart,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              CartIconWidget(
                product: ProductEntities(
                    id: widget.productDetails.id,
                    price: widget.productDetails.price,
                    oldPrice: widget.productDetails.oldPrice,
                    discount: widget.productDetails.discount,
                    image: widget.productDetails.image,
                    name: widget.productDetails.name,
                    images: const [''],
                    description: widget.productDetails.description,
                    inFavorites: widget.productDetails.inFavorites,
                    inCart: widget.productDetails.inCart),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildDescription() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Text(
          widget.productDetails.description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  CarouselSlider buildSliderImages(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.productDetails.images.length,
      itemBuilder: (context, index, n) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CachedNetworkImage(
            imageUrl: widget.productDetails.images[index],
            fit: BoxFit.contain,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
                strokeWidth: 3,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
            ),
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        height: MediaQuery.of(context).size.height / 2.5,
        viewportFraction: 1,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
      ),
    );
  }
}
