import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architicture_ecommerce/features/auth/presentation/widgets/Logout_widget.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
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
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              children: [
                CircleAvatar(
                    radius: 70.w,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: primaryColor),
                          shape: BoxShape.circle),
                    ),
                    backgroundImage:
                        CachedNetworkImageProvider(widget.profile.image)),
                SizedBox(
                  height: 11.h,
                ),
                Row(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.name} :',
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(widget.profile.name),
                  ],
                ),
                SizedBox(
                  height: 11.h,
                ),
                Row(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.phone} :',
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(widget.profile.phone),
                  ],
                ),
                SizedBox(
                  height: 11.h,
                ),
                Row(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.email} :',
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(widget.profile.email),
                  ],
                ),
                SizedBox(
                  height: 11.h,
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
                SizedBox(
                  height: 15.h,
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
                              style: TextStyle(
                                  fontSize: 18.sp,
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
          SizedBox(height: 15.h),
          const LogoutWidget(),
        ],
      ),
    );
  }
}
