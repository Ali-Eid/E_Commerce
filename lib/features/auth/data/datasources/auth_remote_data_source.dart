import 'dart:convert';

import '../../../../core/constants.dart';
import '../../../../core/error/strings/error_messages.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions/exceptions.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String email, String password);
  Future<AuthModel> signUp(
    String name,
    String email,
    String password,
    String phone,
  );
}

const BASE_URL = "https://student.valuxapps.com/api/";

class AuthRemoteDataSourceImplements implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImplements({required this.client});
  @override
  Future<AuthModel> login(String email, String password) async {
    final body = {
      'email': email,
      'password': password,
    };
    final response =
        await client.post(Uri.parse(BASE_URL + 'login'), body: body, headers: {
      'lang': lang!,
    });
    if (response.statusCode == 200) {
      final decodejson = json.decode(response.body) as Map<String, dynamic>;
      if (decodejson['data'] != null) {
        final AuthModel authModel = AuthModel.fromjson(decodejson['data']);
        return authModel;
      } else {
        throw LoginException();
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthModel> signUp(
      String name, String email, String password, String phone) async {
    final body = {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone
    };
    final response = await client
        .post(Uri.parse(BASE_URL + 'register'), body: body, headers: {
      'lang': lang!,
    });
    print(response.body);
    if (response.statusCode == 200) {
      final jsondecode = json.decode(response.body) as Map<String, dynamic>;
      if (jsondecode['data'] != null) {
        final authModel = AuthModel.fromjson(jsondecode['data']);
        return authModel;
      } else {
        SIGN_UP_FAILURE_MESSAGE = jsondecode['message'];
        throw SignUpException();
      }
    } else {
      throw ServerException();
    }
  }
}
