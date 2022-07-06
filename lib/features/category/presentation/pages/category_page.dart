import 'package:clean_architicture_ecommerce/core/widget/no_intenet_widget.dart';
import 'package:clean_architicture_ecommerce/features/banners/presentation/bloc/banners/banners_bloc.dart';

import '../../../cart/presentation/bloc/cart/cart_bloc.dart';
import '../bloc/category/category_bloc.dart';
import '../widgets/category_widget.dart';
import '../../../products/presentation/bloc/products/products_bloc.dart';
import '../../../settings/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      // BlocProvider.of<CartBloc>(context).add(GetCartEvent());
      // BlocProvider.of<ProductsBloc>(context).add(getAllProductsEvent());
      // BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
      return BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is LoadingCategoyState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedCategoyState) {
            return CategoryWidget(category: state.category);
          } else if (state is ErrorGetCategoyState) {
            return RefreshIndicator(
              onRefresh: () async {
                return BlocProvider.of<CategoryBloc>(context)
                    .add(GetCategoryEvent());
              },
              child: ErrorConnectionWidget(
                  text: state.message,
                  pathImg: 'assets/images/serverError.json'),
            );
          } else if (state is OfflineCategoyState) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<BannersBloc>(context)
                    .add(getAllBannersImgEvent());
                return BlocProvider.of<CategoryBloc>(context)
                    .add(GetCategoryEvent());
              },
              child: ErrorConnectionWidget(
                  text: state.message,
                  pathImg: 'assets/images/nointernet.json'),
            );
          }
          return const Text('');
        },
      );
    });
  }
}
