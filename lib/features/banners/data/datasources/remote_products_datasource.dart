import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions/exceptions.dart';
import '../../../auth/data/datasources/auth_remote_data_source.dart';
import '../models/banners_model.dart';

abstract class RemoteBannersDatasource {
  Future<bannersModel> getBannersImg();
}

class RemoteBannersDatasourceImplements implements RemoteBannersDatasource {
  final http.Client client;

  RemoteBannersDatasourceImplements({required this.client});

  @override
  Future<bannersModel> getBannersImg() async {
    try {
      final response =
          await client.get(Uri.parse(BASE_URL + 'banners'), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final jsondecode = json.decode(response.body) as Map<String, dynamic>;
        final jsonToBannersImag = bannersModel.fromJson(jsondecode);
        return jsonToBannersImag;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }
}
