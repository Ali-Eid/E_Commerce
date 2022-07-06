import 'dart:convert';

import '../../../../core/constants.dart';
import '../../../../core/error/exceptions/exceptions.dart';
import '../../../../core/error/failures/failures.dart';
import '../../../auth/data/datasources/auth_remote_data_source.dart';
import '../models/product_favourite_model.dart';
import '../../domain/entities/product_favourite_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<ProductFavouriteEntities> addFavourite(String productid);
  Future<List<ProductFavouriteEntities>> getFavourite();
}

class RemoteAddFavouriteDataSourceImplements implements RemoteDataSource {
  final http.Client client;

  RemoteAddFavouriteDataSourceImplements(this.client);

  @override
  Future<ProductFavouriteEntities> addFavourite(String productid) async {
    try {
      final body = {'product_id': productid};
      final response = await client.post(Uri.parse(BASE_URL + 'favorites'),
          body: body, headers: {'lang': lang!, 'Authorization': token!});

      if (response.statusCode == 200) {
        final jsondecode = json.decode(response.body) as Map<String, dynamic>;
        final jsonToFavourite =
            ProductFavouriteModel.fromjson(jsondecode['data']['product']);

        return jsonToFavourite;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print('add favourite ${e.toString()}');
      throw ServerException();
    }
  }

  @override
  Future<List<ProductFavouriteEntities>> getFavourite() async {
    try {
      final response = await client.get(Uri.parse(BASE_URL + 'favorites'),
          headers: {
            'Content-Type': 'application/json',
            'lang': lang!,
            'Authorization': token!
          });
      if (response.statusCode == 200) {
        final jsondecode = json.decode(response.body) as Map<String, dynamic>;
        final List listJsonDecode = jsondecode['data']['data'];
        final List<FavModel> jsonToFavourite = listJsonDecode
            .map<FavModel>((favourite) => FavModel.fromjson(favourite))
            .toList();
        final List<ProductFavouriteEntities> listFav = [];
        for (var element in jsonToFavourite) {
          listFav.add(element.product!);
        }
        return listFav;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }
}
