import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants.dart';
import 'features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'features/auth/splash_screen_auth.dart';
import 'features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/L10n/l10n.dart';
import 'core/app_theme.dart';
import 'core/utils/observe/bloc_observe.dart';
import 'features/auth/presentation/bloc/login/login_bloc.dart';
import 'features/auth/presentation/bloc/sign_up/signup_bloc.dart';

import 'features/banners/presentation/bloc/banners/banners_bloc.dart';
import 'features/cart/presentation/bloc/add_delete_cart/add_delete_cart_bloc.dart';
import 'features/category/presentation/bloc/category/category_bloc.dart';
import 'features/favourites/presentation/bloc/add_delete_favourite/add_delete_favourite_bloc.dart';
import 'features/favourites/presentation/bloc/favourite/favourite_bloc.dart';
import 'features/products/presentation/bloc/product_details/productdetails_bloc.dart';
import 'features/products/presentation/bloc/products/products_bloc.dart';
import 'features/settings/presentation/bloc/localization/localization_bloc.dart';
import 'features/settings/presentation/bloc/profile/profile_bloc.dart';
import 'home/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  token = sharedPreferences.getString('token') ?? '';
  lang = sharedPreferences.getString('lang') ?? 'en';
  BlocOverrides.runZoned(
    () {
      runApp(Phoenix(
        child: MyApp(
          local: lang!,
        ),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final String local;
  const MyApp({Key? key, required this.local}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<LoginBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<SignupBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<LogoutBloc>(),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<ProductsBloc>()..add(getAllProductsEvent()),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<FavouriteBloc>()..add(GetAllFavouriteProductEvent()),
        ),
        BlocProvider(
          create: (context) => di.sl<AddDeleteFavouriteBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ProductdetailsBloc>(),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<BannersBloc>()..add(getAllBannersImgEvent()),
        ),
        BlocProvider(
          create: (context) => di.sl<CategoryBloc>()..add(GetCategoryEvent()),
        ),
        BlocProvider(
          create: (context) => di.sl<CartBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<AddDeleteCartBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ProfileBloc>()..add(GetProfileEvent()),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<LocalizationBloc>()..add(SetLocalEvent(locale: local)),
        ),
      ],
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, state) {
          return ScreenUtilInit(
              designSize: const Size(
                360,
                690,
              ),
              builder: (context, snapshot) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: apptheme,
                  title: 'E_commerce_clean_architicture',
                  locale: Locale(state.local),
                  supportedLocales: L10n.all,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  home:
                      token != '' ? MyCustomSplashScreen() : SplashScreenAuth(),
                );
              });
        },
      ),
    );
  }
}
