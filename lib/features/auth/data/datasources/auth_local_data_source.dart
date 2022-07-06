import 'dart:convert';

import '../../domain/entities/auth_entities.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<Unit> cached(String token);
  Future<String> getcachedToken();
  // Future<void> saveUser(AuthEntities user);
}

// const CACHED_USER = 'CACHED_USER';

class AuthLocalDataSourceImplements implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImplements(this.sharedPreferences);

  @override
  Future<Unit> cached(String token) async {
    await sharedPreferences.setString('token', token);
    return Future.value(unit);
  }

  @override
  Future<String> getcachedToken() async {
    final _sharedPreferencesToken = sharedPreferences.getString('token');
    if (_sharedPreferencesToken != null) {
      return Future.value(_sharedPreferencesToken);
    } else {
      return Future.value('null');
    }

    // throw UnimplementedError();
  }

  // @override
  // Future<void> saveUser(AuthEntities user) {
  //   return sharedPreferences.setString(CACHED_USER, json.encode(user));
  // }
}
