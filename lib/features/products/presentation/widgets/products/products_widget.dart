import 'package:flutter_screenutil/src/size_extension.dart';

import '../../../../../core/app_theme.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../data/models/products_model.dart';
import '../../../domain/entities/products_entities.dart';
import 'product_item_widget.dart';

import 'package:flutter/material.dart';

class ProductsWidet extends StatelessWidget {
  final List<ProductEntities> productEntities;
  const ProductsWidet({Key? key, required this.productEntities})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _w = MediaQuery.of(context).size.width;
    return GridView.builder(
      itemCount: productEntities.length,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return AnimationLimiter(
            child: AnimationConfiguration.staggeredGrid(
          position: index,
          duration: const Duration(milliseconds: 500),
          columnCount: 2,
          child: ScaleAnimation(
            duration: const Duration(milliseconds: 900),
            curve: Curves.fastLinearToSlowEaseIn,
            scale: 1.5,
            child: FadeInAnimation(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                // margin: EdgeInsets.only(
                //     bottom: _w / 30, left: _w / 60, right: _w / 60),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.1),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: ProductItemWidget(
                  model: productEntities[index],
                ),
              ),
            ),
          ),
        ));
      },
    );
  }
}
