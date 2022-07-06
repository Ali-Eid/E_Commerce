import '../bloc/product_details/productdetails_bloc.dart';
import '../widgets/product_details/product_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsDetailsPage extends StatelessWidget {
  const ProductsDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductdetailsBloc, ProductdetailsState>(
      builder: (context, state) {
        if (state is SuccessDetailsProductState) {
          return ProductDetailsWidget(
            productDetails: state.product,
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
