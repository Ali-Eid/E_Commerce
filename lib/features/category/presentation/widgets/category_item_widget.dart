import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/app_theme.dart';
import '../../domain/entities/category_entities.dart';
import '../bloc/category/category_bloc.dart';
import '../bloc/category_details/category_details_bloc.dart';
import '../pages/category_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryItemWidget extends StatelessWidget {
  final CategoryEntities model;
  const CategoryItemWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => CategorDetailsPage(
                  categoryid: model.id,
                )));
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CachedNetworkImage(
          width: double.infinity,
          height: _w / 4,
          imageUrl: model.image,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        const SizedBox(
          height: 15,
        ),
        Center(
          child: Text(model.name,
              maxLines: 2, style: const TextStyle(fontSize: 18)),
        ),
      ]),
    );
  }
}
