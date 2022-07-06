import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../data/models/banners_model.dart';

class BannersWidget extends StatelessWidget {
  final List<DataBanners> banners;
  const BannersWidget({Key? key, required this.banners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildSlider(context),
        ],
      ),
    );
  }

  CarouselSlider _buildSlider(BuildContext context) {
    return CarouselSlider(
      items: banners
          .map(
            (e) => CachedNetworkImage(
              fit: BoxFit.fill,
              width: double.infinity,
              imageUrl: "${e.image}",
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.25,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.linear,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
