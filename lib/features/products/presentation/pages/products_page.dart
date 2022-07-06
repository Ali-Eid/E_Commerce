import '../../../../core/widget/no_intenet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/products/products_bloc.dart';
import '../widgets/products/products_widget.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is LoadingRefreshDetailsProductState) {
          return const Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is LoadingProductsState) {
          return const Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is SuccessGetAllProductsState) {
          return RefreshIndicator(
            onRefresh: () async {
              return BlocProvider.of<ProductsBloc>(context)
                  .add(refreshAllProductsEvent());
            },
            child: ProductsWidet(
              productEntities: state.products,
            ),
          );
        } else if (state is ErrorGetAllProductsState) {
          return RefreshIndicator(
            onRefresh: () async {
              return BlocProvider.of<ProductsBloc>(context)
                  .add(refreshAllProductsEvent());
            },
            child: ErrorConnectionWidget(
                text: state.message, pathImg: 'assets/images/serverError.json'),
          );
        } else if (state is OfflineProductsState) {
          return RefreshIndicator(
            onRefresh: () async {
              return BlocProvider.of<ProductsBloc>(context)
                  .add(refreshAllProductsEvent());
            },
            child: ErrorConnectionWidget(
                text: state.message, pathImg: 'assets/images/nointernet.json'),
          );
        }

        return const Text('');
      },
    );
  }
}
