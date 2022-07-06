import '../features/cart/domain/entities/cart_entitiy.dart';
import 'package:flutter/material.dart';

import '../features/favourites/domain/entities/product_favourite_entity.dart';

String? token;
String? lang;
List<ProductFavouriteEntities> inFav = [];
List<CartEntity> inCart = [];
Map<int, dynamic> isFav = {};
Map<int, dynamic> isCart = {};
