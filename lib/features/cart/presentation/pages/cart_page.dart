import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/widget/no_intenet_widget.dart';
import '../bloc/cart/cart_bloc.dart';
import '../widgets/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is LoadingCart) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedCart) {
            return CartWidget(
              carts: state.carts,
            );
          } else if (state is ErrorGetCart) {
            return RefreshIndicator(
              onRefresh: () async {
                return BlocProvider.of<CartBloc>(context).add(GetCartEvent());
              },
              child: ErrorConnectionWidget(
                  text: state.message,
                  pathImg: 'assets/images/serverError.json'),
            );
          } else if (state is OfflineGetCartState) {
            return RefreshIndicator(
              onRefresh: () async {
                return BlocProvider.of<CartBloc>(context).add(GetCartEvent());
              },
              child: ErrorConnectionWidget(
                  text: state.message,
                  pathImg: 'assets/images/nointernet.json'),
            );
          }

          return const Center(
            child: Text(''),
          );
        },
      ),
    );
  }
}
