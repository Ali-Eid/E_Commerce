import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import '../bloc/add_delete_favourite/add_delete_favourite_bloc.dart';
import '../../../products/presentation/bloc/product_details/productdetails_bloc.dart';
import '../../../products/presentation/pages/product_details_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../domain/entities/product_favourite_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouritesWidget extends StatelessWidget {
  final List<ProductFavouriteEntities> favourite;
  const FavouritesWidget({Key? key, required this.favourite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    return BlocBuilder<AddDeleteFavouriteBloc, AddDeleteFavouriteState>(
      builder: (context, state) {
        return favourite.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/favourites.png'),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.no_favourites,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ))
                ],
              )
            : AnimationLimiter(
                child: SafeArea(
                  child: ListView.builder(
                    padding: EdgeInsets.all(_w / 30),
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: favourite.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          verticalOffset: -250,
                          child: ScaleAnimation(
                            duration: const Duration(milliseconds: 1500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: itemFavourite(_w, index, context),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
      },
    );
  }

  InkWell itemFavourite(double _w, int index, BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<ProductdetailsBloc>(context)
            .add(getDetailsProductEvent(id: favourite[index].id!));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const ProductsDetailsPage(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: _w / 20),
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.1),
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Container(
                width: 60.h,
                height: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(favourite[index].image!),
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                flex: 1,
                child: Text(favourite[index].name, overflow: TextOverflow.fade),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
