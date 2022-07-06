import 'dart:convert';

import '../../../../core/constants.dart';
import '../../../../core/error/exceptions/exceptions.dart';
import '../../../auth/data/datasources/auth_remote_data_source.dart';
import '../models/cart_model.dart';
import 'package:http/http.dart' as http;

abstract class CartRemoteDataSource {
  Future<List<CartModel>> getcart();
  Future<CartModel> addTocart(String productid);
  Future<CartModel> updatequantity(String cartid, String quantity);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final http.Client client;

  CartRemoteDataSourceImpl(this.client);
  @override
  Future<List<CartModel>> getcart() async {
    try {
      final response = await client.get(Uri.parse(BASE_URL + 'carts'),
          headers: {
            'Content-Type': 'application/json',
            'lang': lang!,
            'Authorization': token!
          });
      if (response.statusCode == 200) {
        final jsondecode = json.decode(response.body) as Map<String, dynamic>;
        final List listofjsonCart = jsondecode['data']['cart_items'];
        final jsonToCart = listofjsonCart
            .map<CartModel>((cartmodel) => CartModel.fromjson(cartmodel))
            .toList();
        inCart = jsonToCart;
        return jsonToCart;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print('error cart ${e.toString()}');
      throw ServerException();
    }
  }

  @override
  Future<CartModel> addTocart(String productid) async {
    try {
      final body = {'product_id': productid};
      final response = await client.post(Uri.parse(BASE_URL + 'carts'),
          body: body, headers: {'lang': lang!, 'Authorization': token!});
      if (response.statusCode == 200) {
        final jsondecode = json.decode(response.body) as Map<String, dynamic>;
        final jsonToCart = CartModel.fromjson(jsondecode['data']);
        return jsonToCart;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print('error in add to cart ${e.toString()}');
      throw ServerException();
    }
  }

  @override
  Future<CartModel> updatequantity(String cartid, String quantity) async {
    try {
      final body = {'quantity': quantity};
      final response = await client
          .put(Uri.parse(BASE_URL + 'carts/$cartid'), body: body, headers: {
        'lang': lang!,
        'Authorization': token!,
      });
      if (response.statusCode == 200) {
        final jsondecode = json.decode(response.body) as Map<String, dynamic>;
        final jsonToCart = CartModel.fromjson(jsondecode['data']['cart']);
        return jsonToCart;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }
}
