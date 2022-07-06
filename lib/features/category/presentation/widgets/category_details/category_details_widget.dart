import '../../../../../core/app_theme.dart';
import '../../../domain/entities/category_details_entitites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'category_details_item_widget.dart';

class CategoryDetailsWidget extends StatelessWidget {
  final List<CategoryDetailsEntities> categoryDetails;
  const CategoryDetailsWidget({Key? key, required this.categoryDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _w = MediaQuery.of(context).size.width;
    return GridView.builder(
      itemCount: categoryDetails.length,
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
                margin: EdgeInsets.only(
                    bottom: _w / 30, left: _w / 60, right: _w / 60),
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
                child: CategoryDetailsItemWidget(
                  model: categoryDetails[index],
                ),
              ),
            ),
          ),
        ));
      },
    );
  }
}
