import 'core/network/network_connection.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/cart/data/datasources/remote_data_source.dart';
import 'features/cart/data/repository/cart_repository_implements.dart';
import 'features/cart/domain/repository/cart_repository.dart';
import 'features/cart/domain/usecases/add_to_cart.dart';
import 'features/cart/domain/usecases/get_cart_usecase.dart';
import 'features/cart/domain/usecases/update_quantity.dart';
import 'features/cart/presentation/bloc/add_delete_cart/add_delete_cart_bloc.dart';
import 'features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'features/category/data/repository/category_repository_implement.dart';
import 'features/category/domain/repository/category_repository.dart';
import 'features/category/domain/usecases/get_category_details.dart';
import 'features/category/domain/usecases/get_category_usecase.dart';
import 'features/category/presentation/bloc/category/category_bloc.dart';
import 'features/category/presentation/bloc/category_details/category_details_bloc.dart';
import 'features/products/data/datasources/local_data_source.dart';
import 'features/settings/data/datasource/local_data_source.dart';
import 'features/settings/data/datasource/remote_data_source.dart';
import 'features/settings/data/repository/setting_repository_implement.dart';
import 'features/settings/domain/repository/setting_repositroy.dart';
import 'features/settings/domain/usecases/get_profile_usecase.dart';
import 'features/settings/domain/usecases/set_language.dart';
import 'features/settings/domain/usecases/update_profile.usecase.dart';
import 'features/settings/presentation/bloc/localization/localization_bloc.dart';
import 'features/settings/presentation/bloc/profile/profile_bloc.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repository/auth_repository_implement.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/presentation/bloc/login/login_bloc.dart';
import 'features/auth/presentation/bloc/sign_up/signup_bloc.dart';
import 'features/banners/data/repository/banners_repository_implements.dart';
import 'features/banners/domain/usecases/get_img_banners.dart';
import 'features/banners/presentation/bloc/banners/banners_bloc.dart';
import 'features/category/data/datasources/local_data_source.dart';
import 'features/category/data/datasources/remote_data_source.dart';
import 'features/favourites/data/datasources/local_data_source.dart';
import 'features/favourites/data/datasources/remote_data_source.dart';
import 'features/favourites/data/repository/favourite_repository_implement.dart';
import 'features/favourites/domain/repository/favourite_repository.dart';
import 'features/favourites/domain/usecases/add_favourite.dart';
import 'features/favourites/domain/usecases/get_favourite.dart';
import 'features/products/data/datasources/remote_products_datasource.dart';
import 'features/products/domain/usecases/get_all_products.dart';
import 'features/products/domain/usecases/get_products_details.dart';
import 'features/products/presentation/bloc/product_details/productdetails_bloc.dart';
import 'features/products/presentation/bloc/products/products_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'features/banners/data/datasources/remote_products_datasource.dart';
import 'features/banners/domain/repository/banners_repository.dart';
import 'features/favourites/presentation/bloc/add_delete_favourite/add_delete_favourite_bloc.dart';
import 'features/favourites/presentation/bloc/favourite/favourite_bloc.dart';
import 'features/products/data/repository/products_repository_implements.dart';
import 'features/products/domain/repository/products_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //bloc

  //Auth Blocs
  sl.registerFactory(
    () => LoginBloc(
      login: sl(),
    ),
  );
  sl.registerFactory(
    () => SignupBloc(
      signUp: sl(),
    ),
  );
//--------------
//Products Blocs

  sl.registerFactory(
    () => ProductsBloc(
      getAllProducts: sl(),
      getProductDetails: sl(),
    ),
  );
  sl.registerFactory(
    () => ProductdetailsBloc(
      getProductDetails: sl(),
    ),
  );
//---------------
//---------Banners Bloc
  sl.registerFactory(
    () => BannersBloc(
      getImagBanners: sl(),
    ),
  );
//-------------Favoutire blocs
  sl.registerFactory(
    () => FavouriteBloc(
      getAllFavourite: sl(),
    ),
  );
  sl.registerFactory(
    () => AddDeleteFavouriteBloc(
      addFavourite: sl(),
    ),
  );
//---------------------------
//-------Cart Bloc--------
  sl.registerFactory(
    () => CartBloc(
      getCart: sl(),
    ),
  );

  sl.registerFactory(
    () => AddDeleteCartBloc(
      addToCart: sl(),
      updateQuantity: sl(),
    ),
  );
//---------------
//     Categroy blocs
  sl.registerFactory(
    () => CategoryBloc(
      getCategory: sl(),
    ),
  );
  sl.registerFactory(
    () => CategoryDetailsBloc(
      getCategoryDetails: sl(),
    ),
  );

//---------------
//-----Profile------
  sl.registerFactory(
    () => ProfileBloc(
      getProfile: sl(),
      updateProfile: sl(),
    ),
  );
  sl.registerFactory(
    () => LocalizationBloc(setLanguage: sl()),
  );

  //UseCase
  sl.registerLazySingleton(
    () => LoginUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SignUpUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetAllProductsUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetImagBannersUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetProductDetailsUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => AddFavouriteUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetAllFavouriteUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetCategoryUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetCategoryDetailsUseCase(
      sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetCartUseCase(
      sl(),
    ),
  );

  sl.registerLazySingleton(
    () => AddToCartUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => UpdateQuantityUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetProfileUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => UpdateProfileUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SetLanguageUseCase(
      sl(),
    ),
  );

  //Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImplements(
      authLocalDataSource: sl(),
      authRemoteDataSource: sl(),
      networkConnection: sl(),
    ),
  );
  sl.registerLazySingleton<RepositoryProducts>(
    () => ProductsRepositoryImplements(
      remoteDatasource: sl(),
      localDatasource: sl(),
      networkConnection: sl(),
    ),
  );
  sl.registerLazySingleton<RepositoryImgBanner>(
    () => BannersRepositoryImplements(
      remoteDatasource: sl(),
    ),
  );
  sl.registerLazySingleton<FavouriteRepository>(
    () => FavouriteRepositoryImplement(sl(), sl(), sl()),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepoImplement(sl(), sl(), sl()),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoyImplements(
      sl(),
      sl(),
    ),
  );
  sl.registerLazySingleton<SettingRepository>(
    () => SettingRepositoryImpl(
      sl(),
      sl(),
      sl(),
    ),
  );
  //Data Sources

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImplements(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImplements(
      sl(),
    ),
  );
  sl.registerLazySingleton<RemoteDatasource>(
    () => RemoteDataSourceImplements(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<RemoteBannersDatasource>(
    () => RemoteBannersDatasourceImplements(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteAddFavouriteDataSourceImplements(
      sl(),
    ),
  );
  sl.registerLazySingleton<RemoteCategoryDataSource>(
    () => RemoteCategoryDataSourceImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<RemoteSettingDataSource>(
    () => RemoteSettingDataSourceImplement(
      sl(),
    ),
  );
  sl.registerLazySingleton<SettingLocalDataSource>(
    () => SettingLocalDataSourceImpl(
      sl(),
    ),
  );

  sl.registerLazySingleton<LocalProductDataSource>(
    () => localProductDataSourceImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<LocalCategoryDataSource>(
    () => LocalCategoryDataSourceImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<LocalFavouriteDataSource>(
    () => LocalFavouriteDataSourceImpl(
      sl(),
    ),
  );
  //----------
  //Core

  sl.registerLazySingleton<NetworkConnection>(
      () => NetworkConnectionImplements(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
