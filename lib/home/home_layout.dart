import 'package:clean_architicture_ecommerce/features/favourites/presentation/pages/favourite_page.dart';

import '../features/cart/presentation/bloc/add_delete_cart/add_delete_cart_bloc.dart';
import '../features/cart/presentation/bloc/cart/cart_bloc.dart';
import '../features/products/presentation/pages/products_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import '../core/constants.dart';
import '../features/cart/presentation/pages/cart_page.dart';
import '../features/favourites/presentation/bloc/favourite/favourite_bloc.dart';
import '../features/favourites/presentation/widgets/favourites_widget.dart';

import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  // final GlobalKey _key = GlobalKey();
  final List<Widget> pages = [
    const HomePage(),
    const ProductsPage(),
    const FavouritePage(),
    const SettingPage()
  ];
  int indexx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: pages[indexx],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        extendBody: true,
        floatingActionButton: FloatingActionButton(
          // elevation: 20,
          key: BlocProvider.of<AddDeleteCartBloc>(context).keyCart,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: const Icon(Icons.shopping_cart_sharp),
          onPressed: () {
            BlocProvider.of<CartBloc>(context).add(GetCartEvent());
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartPage()));
          },
        ),
        bottomNavigationBar: _buildBottomAppBar(context));
  }

  BottomAppBar _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).scaffoldBackgroundColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 20),
            child: buildTabItem(
              context: context,
              index: 0,
              icon: const Icon(Icons.home),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 20),
            child: buildTabItem(
              context: context,
              index: 1,
              icon: const Icon(Icons.category),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 20),
            child: buildTabItem(
              context: context,
              index: 2,
              icon: const Icon(Icons.favorite_border_outlined),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 20),
            child: buildTabItem(
              context: context,
              index: 3,
              icon: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabItem({
    required context,
    required int index,
    required Icon icon,
  }) {
    return IconButton(
      onPressed: () {
        setState(() {
          indexx = index;
        });
      },
      icon: icon,
      color: indexx == index ? Colors.purple : Colors.purple.withOpacity(0.60),
    );
  }
}
