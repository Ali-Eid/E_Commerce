import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/app_theme.dart';
import '../../../cart/presentation/bloc/cart/cart_bloc.dart';
import '../../../category/presentation/bloc/category/category_bloc.dart';
import '../../../favourites/presentation/bloc/favourite/favourite_bloc.dart';
import '../../../products/presentation/bloc/products/products_bloc.dart';
import '../../domain/entities/profile_entity.dart';
import '../bloc/localization/localization_bloc.dart';
import '../pages/profile/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingWidget extends StatefulWidget {
  final ProfileEntitiy profile;
  const SettingWidget({Key? key, required this.profile}) : super(key: key);

  @override
  State<SettingWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<SettingWidget> {
  String _local = 'en';

  @override
  Widget build(BuildContext context) {
    final _w = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: _w / 8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _w / 8),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.20,
                    child: Container(
                      decoration: BoxDecoration(
                          // color: primaryColor,
                          border: Border.all(width: 0.5, color: primaryColor),
                          shape: BoxShape.circle),
                    ),
                    // radius: 75,
                    backgroundImage:
                        CachedNetworkImageProvider(widget.profile.image)),
                const SizedBox(
                  height: 11,
                ),
                Row(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.name} :',
                      style: const TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(widget.profile.name),
                  ],
                ),
                const SizedBox(
                  height: 11,
                ),
                Row(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.phone} :',
                      style: const TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(widget.profile.phone),
                  ],
                ),
                const SizedBox(
                  height: 11,
                ),
                Row(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.email} :',
                      style: const TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(widget.profile.email),
                  ],
                ),
                const SizedBox(
                  height: 11,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => EditProfilePage(
                                  profile: widget.profile,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          label:
                              Text(AppLocalizations.of(context)!.edit_profile)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<LocalizationBloc, LocalizationState>(
                  builder: (context, state) {
                    _local = state.local;
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: primaryColor),
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.change_language,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            title: const Text('English'),
                            leading: Radio(
                                value: 'en',
                                groupValue: _local,
                                onChanged: (value) {
                                  BlocProvider.of<LocalizationBloc>(context)
                                      .add(SetLocalEvent(
                                          locale: value.toString()));
                                  setState(() {
                                    _local = value.toString();
                                  });
                                  BlocProvider.of<CategoryBloc>(context)
                                      .add(GetCategoryEvent());
                                  BlocProvider.of<CartBloc>(context)
                                      .add(GetCartEvent());
                                  BlocProvider.of<ProductsBloc>(context)
                                      .add(getAllProductsEvent());
                                  BlocProvider.of<FavouriteBloc>(context)
                                      .add(GetAllFavouriteProductEvent());
                                }),
                          ),
                          ListTile(
                            title: const Text('العربية'),
                            leading: Radio(
                                value: 'ar',
                                groupValue: _local,
                                onChanged: (value) {
                                  BlocProvider.of<LocalizationBloc>(context)
                                      .add(SetLocalEvent(
                                          locale: value.toString()));
                                  setState(() {
                                    _local = value.toString();
                                  });
                                  // Phoenix.rebirth(context);
                                  BlocProvider.of<CategoryBloc>(context)
                                      .add(GetCategoryEvent());
                                  BlocProvider.of<CartBloc>(context)
                                      .add(GetCartEvent());
                                  BlocProvider.of<ProductsBloc>(context)
                                      .add(getAllProductsEvent());
                                  BlocProvider.of<FavouriteBloc>(context)
                                      .add(GetAllFavouriteProductEvent());
                                }),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
