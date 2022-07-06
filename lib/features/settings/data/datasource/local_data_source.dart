import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingLocalDataSource {
  Future<Unit> cachedLang(String lang);
  Future<String> getcachedLang();
}

class SettingLocalDataSourceImpl implements SettingLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingLocalDataSourceImpl(this.sharedPreferences);
  @override
  Future<Unit> cachedLang(String lang) async {
    await sharedPreferences.setString('lang', lang);
    return Future.value(unit);
  }

  @override
  Future<String> getcachedLang() async {
    final _sharedPreferencesToken = sharedPreferences.getString('lang');
    if (_sharedPreferencesToken != null) {
      return Future.value(_sharedPreferencesToken);
    } else {
      return Future.value('null');
    }
  }
}
