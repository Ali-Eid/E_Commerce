import '../../../../core/app_theme.dart';
import '../../../../core/constants.dart';
import '../../domain/entities/cart_entitiy.dart';
import '../bloc/add_delete_cart/add_delete_cart_bloc.dart';
import '../bloc/cart/cart_bloc.dart';
import '../../../products/domain/entities/products_entities.dart';
import 'package:easycartanimation/easycartanimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartIconWidget extends StatefulWidget {
  @override
  // final GlobalKey key;
  final ProductEntities product;
  const CartIconWidget({
    Key? key,
    required this.product,
    //  required this.key
  }) : super(key: key);

  @override
  State<CartIconWidget> createState() => _CartIconWidgetState();
}

class _CartIconWidgetState extends State<CartIconWidget> {
  Offset? _endOffset;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((c) {
      // Get the location of the "shopping cart"
      _endOffset = (BlocProvider.of<AddDeleteCartBloc>(context)
              .keyCart
              .currentContext!
              .findRenderObject() as RenderBox)
          .localToGlobal(Offset.zero);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            setState(() {
              if (isCart[widget.product.id]) {
                var _overlayEntry = OverlayEntry(builder: (_) {
                  RenderBox? box = context.findRenderObject() as RenderBox?;
                  var offset = box!.localToGlobal(Offset.zero);
                  return EasyCartAnimation(
                    startPosition: _endOffset,
                    endPosition: offset,
                    height: 35,
                    width: 35,
                    color: primaryColor,
                    dxCurveAnimation: 55,
                    dyCurveAnimation: 250,
                    opacity: 0.5,
                  );
                });
                // Show Overlay
                Overlay.of(context)!.insert(_overlayEntry);
                // wait for the animation to end
                Future.delayed(const Duration(milliseconds: 800), () {
                  _overlayEntry.remove();
                  // _overlayEntry = null;
                });
                BlocProvider.of<AddDeleteCartBloc>(context).add(
                  DeleteFromCartEvent(
                      product: CartEntity(
                    id: 1,
                    quantity: 1,
                    product: CartProduct(
                      description: widget.product.name!,
                      name: widget.product.name!,
                      id: widget.product.id!,
                      price: widget.product.price!,
                      oldPrice: widget.product.oldPrice!,
                      discount: widget.product.discount!,
                      image: widget.product.image!,
                    ),
                  )),
                );
                BlocProvider.of<CartBloc>(context).add(GetCartEvent());
              } else {
                var _overlayEntry = OverlayEntry(builder: (_) {
                  RenderBox? box = context.findRenderObject() as RenderBox?;
                  var offset = box!.localToGlobal(Offset.zero);
                  return EasyCartAnimation(
                    startPosition: offset,
                    endPosition: _endOffset,
                    height: 35,
                    width: 35,
                    color: primaryColor,
                    dxCurveAnimation: 250,
                    dyCurveAnimation: 50,
                    opacity: 0.5,
                  );
                });
                // Show Overlay
                Overlay.of(context)!.insert(_overlayEntry);
                // wait for the animation to end
                Future.delayed(const Duration(milliseconds: 800), () {
                  _overlayEntry.remove();
                  // _overlayEntry = null;
                });
                BlocProvider.of<AddDeleteCartBloc>(context).add(
                  AddToCartEvent(
                      product: CartEntity(
                    id: 1,
                    quantity: 1,
                    product: CartProduct(
                      description: widget.product.name!,
                      name: widget.product.name!,
                      id: widget.product.id!,
                      price: widget.product.price!,
                      oldPrice: widget.product.oldPrice!,
                      discount: widget.product.discount!,
                      image: widget.product.image!,
                    ),
                  )),
                );
                BlocProvider.of<CartBloc>(context).add(GetCartEvent());
              }
            });
          },
          icon: isCart[widget.product.id]
              // model.inFavorites!
              ? const Icon(
                  Icons.shopping_cart,
                  color: primaryColor,
                )
              : const Icon(
                  Icons.shopping_cart_outlined,
                  color: primaryColor,
                ),
        );
      },
    );
  }
}
