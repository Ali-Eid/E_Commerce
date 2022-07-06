import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/constants.dart';
import '../../domain/entities/cart_entitiy.dart';
import '../bloc/add_delete_cart/add_delete_cart_bloc.dart';
import '../bloc/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartWidget extends StatefulWidget {
  final List<CartEntity> carts;
  const CartWidget({Key? key, required this.carts}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return BlocConsumer<AddDeleteCartBloc, AddDeleteCartState>(
      listener: (context, state) {
        if (state is updatequantityState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.add_quantitiy),
              backgroundColor: primaryColor,
              duration: const Duration(seconds: 1),
              elevation: 5,
            ),
          );
        }
      },
      builder: (context, state) {
        return inCart.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/cart.png'),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.cart_empty,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ))
                ],
              )
            : RefreshIndicator(
                onRefresh: () async {
                  return BlocProvider.of<CartBloc>(context).add(GetCartEvent());
                },
                child: AnimationLimiter(
                  child: SafeArea(
                    child: ListView.builder(
                      padding: EdgeInsets.all(_w / 30),
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: inCart.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          delay: const Duration(milliseconds: 100),
                          child: SlideAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            verticalOffset: -250,
                            child: ScaleAnimation(
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: Container(
                                margin: EdgeInsets.only(bottom: _w / 20),
                                height: _w / 3,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.purple.withOpacity(0.1),
                                      blurRadius: 40,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child:
                                      buildItemCart(_w, inCart[index], index),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget buildItemCart(double _w, CartEntity cart, int index) {
    return BlocBuilder<AddDeleteCartBloc, AddDeleteCartState>(
      builder: (context, state) {
        return Row(
          children: [
            Container(
              width: _w / 6,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(cart.product.image!),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cart.product.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.price} :',
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('${cart.product.price * cart.quantity}'),
                        ),
                        cart.product.price != cart.product.oldPrice
                            ? Text(
                                '${cart.product.oldPrice * cart.quantity}',
                                style: const TextStyle(
                                  color: primaryColor,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: primaryColor,
                                ),
                              )
                            : const Text(''),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (cart.quantity == 1) {
                            } else {
                              setState(() {
                                cart.quantity = cart.quantity - 1;
                              });
                            }
                          });
                        },
                        child: Container(
                            width: 50,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: primaryColor, shape: BoxShape.circle),
                            child: const Text(
                              'ــ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Text('${cart.quantity}'),
                      InkWell(
                        onTap: () {
                          setState(() {
                            cart.quantity = cart.quantity + 1;
                          });
                        },
                        child: Container(
                          width: 50,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: primaryColor, shape: BoxShape.circle),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            BlocProvider.of<AddDeleteCartBloc>(context).add(
                                UpdateQuantityEvent(
                                    cartid: cart.id.toString(),
                                    quantity: cart.quantity));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.update,
                          ))
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  BlocProvider.of<AddDeleteCartBloc>(context).add(
                    DeleteFromCartEvent(
                      product: cart,
                    ),
                  );
                  inCart.remove(inCart[index]);
                });
              },
              icon: const Icon(
                Icons.delete,
                color: primaryColor,
              ),
            )
          ],
        );
      },
    );
  }
}
