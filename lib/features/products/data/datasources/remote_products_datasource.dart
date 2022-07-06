import 'dart:convert';
import '../../../../core/constants.dart';
import '../../../../core/error/exceptions/exceptions.dart';
import '../../../auth/data/datasources/auth_remote_data_source.dart';
import '../../../favourites/domain/entities/product_favourite_entity.dart';
import '../models/product_details_model.dart';
import '../models/products_model.dart';
import '../../domain/entities/products_entities.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDatasource {
  Future<List<ProductEntities>> getAllProducts();
  Future<ProductDetailsModel> getProductDetails(int productid);
}

class RemoteDataSourceImplements implements RemoteDatasource {
  final http.Client client;

  RemoteDataSourceImplements({required this.client});
  @override
  Future<List<ProductEntities>> getAllProducts() async {
    try {
      final response =
          await client.get(Uri.parse(BASE_URL + 'products'), headers: {
        'Content-Type': 'application/json',
        'lang': lang!,
        'Authorization': token!,
      });
      if (response.statusCode == 200) {
        final decodejson = json.decode(response.body) as Map<String, dynamic>;
        final List<ProductEntities> productsModel = decodejson['data']['data']
            .map<ProductEntities>((product) => ProductsModel.fromjson(product))
            .toList();
        for (var element in productsModel) {
          isFav.addAll({element.id!: element.inFavorites});
          isCart.addAll({element.id!: element.inCart});
        }
        return productsModel;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<ProductDetailsModel> getProductDetails(int productid) async {
    try {
      final response = await client.get(
        Uri.parse(
          BASE_URL + 'products/' + productid.toString(),
        ),
        headers: {
          'Content-Type': 'application/json',
          'lang': lang!,
        },
      );

      if (response.statusCode == 200) {
        final jsondecode = json.decode(response.body) as Map<String, dynamic>;
        final ProductDetailsModel jsonToProduct =
            ProductDetailsModel.fromjson(jsondecode['data']);
        return jsonToProduct;
      } else {
        print(response);
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }
}
