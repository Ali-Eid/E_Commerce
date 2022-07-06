import 'dart:convert';

import '../../../../core/constants.dart';
import '../../../../core/error/exceptions/exceptions.dart';
import '../../../auth/data/datasources/auth_remote_data_source.dart';
import '../model/profile_model.dart';
import '../../domain/entities/profile_entity.dart';
import 'package:http/http.dart' as http;

abstract class RemoteSettingDataSource {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile({required ProfileEntitiy profile});
}

class RemoteSettingDataSourceImplement implements RemoteSettingDataSource {
  final http.Client client;

  RemoteSettingDataSourceImplement(this.client);
  @override
  Future<ProfileModel> getProfile() async {
    try {
      final response = await client.get(Uri.parse(BASE_URL + 'profile'),
          headers: {
            'Content-Type': 'application/json',
            'lang': lang!,
            'Authorization': token!
          });
      if (response.statusCode == 200) {
        final jsondecode = json.decode(response.body) as Map<String, dynamic>;
        final jsonToProfile = ProfileModel.fromjson(jsondecode['data']);
        print('profile is $jsonToProfile');
        return jsonToProfile;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<ProfileModel> updateProfile({
    required ProfileEntitiy profile,
  }) async {
    try {
      final body = {
        'name': profile.name,
        'email': profile.email,
        'phone': profile.phone,
      };
      final response = await client
          .put(Uri.parse(BASE_URL + 'update-profile'), body: body, headers: {
        'lang': lang!,
        'Authorization': token!,
      });

      if (response.statusCode == 200) {
        final jsondecode = json.decode(response.body) as Map<String, dynamic>;
        print(' profile update is  ${jsondecode['data']}');
        final ProfileModel jsonToProfile =
            ProfileModel.fromjson(jsondecode['data']);
        return jsonToProfile;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }
}
