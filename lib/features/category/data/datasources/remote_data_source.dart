import 'dart:convert';

import '../../../../core/constants.dart';
import '../../../../core/error/exceptions/exceptions.dart';
import '../../../auth/data/datasources/auth_remote_data_source.dart';
import '../models/category_details_model.dart';
import '../models/category_model.dart';
import '../../domain/entities/category_details_entitites.dart';
import '../../domain/entities/category_entities.dart';
import 'package:http/http.dart' as http;

abstract class RemoteCategoryDataSource {
  Future<List<CategoryEntities>> getCategory();
  Future<List<CategoryDetailsEntities>> getDetailsCategory(int id);
}

class RemoteCategoryDataSourceImpl implements RemoteCategoryDataSource {
  final http.Client client;

  RemoteCategoryDataSourceImpl(this.client);
  @override
  Future<List<CategoryEntities>> getCategory() async {
    final response = await client.get(
      Uri.parse(BASE_URL + 'categories'),
      headers: {
        'Content-Type': 'application/json',
        'lang': lang!,
      },
    );
    if (response.statusCode == 200) {
      final jsondecod = json.decode(response.body) as Map<String, dynamic>;
      final List listofjson = jsondecod['data']['data'];
      final List<CategoryModel> jsonToCategory = listofjson
          .map<CategoryModel>((category) => CategoryModel.fromjson(category))
          .toList();
      return jsonToCategory;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CategoryDetailsEntities>> getDetailsCategory(int id) async {
    try {
      final response = await client.get(Uri.parse(BASE_URL + 'categories/$id'),
          headers: {
            'Content-Type': 'application/json',
            'lang': lang!,
            'Authorization': token!
          });
      if (response.statusCode == 200) {
        final jsondecode = json.decode(response.body) as Map<String, dynamic>;
        final List listofjson = jsondecode['data']['data'];
        final jsonToCategoryDetails = listofjson
            .map<CategoryDetailsModel>((categoryDetails) =>
                CategoryDetailsModel.fromjson(categoryDetails))
            .toList();
        for (var element in jsonToCategoryDetails) {
          isFav.addAll({element.id: element.inFavorites});
          isCart.addAll({element.id: element.inCart});
        }
        // print('zero is ${jsonToCategoryDetails[0]}');
        return jsonToCategoryDetails;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print('error is ${e.toString()}');
      throw ServerException();
    }
  }
}
