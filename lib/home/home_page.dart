import '../core/constants.dart';
import '../features/category/presentation/bloc/category/category_bloc.dart';
import '../features/category/presentation/pages/category_page.dart';
import '../features/favourites/presentation/bloc/favourite/favourite_bloc.dart';

import '../features/banners/presentation/pages/banners_page.dart';
import '../features/products/presentation/bloc/products/products_bloc.dart';
import '../features/products/presentation/pages/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.001),
              const BannersPage(),
              const Expanded(child: CategoryPage())
            ],
          );
        },
      ),
    );
  }
}
