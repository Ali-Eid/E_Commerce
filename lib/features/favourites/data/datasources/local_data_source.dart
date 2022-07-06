import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalFavouriteDataSource {
  Future<String> getcachedLang();
}

class LocalFavouriteDataSourceImpl implements LocalFavouriteDataSource {
  final SharedPreferences sharedPreferences;

  LocalFavouriteDataSourceImpl(this.sharedPreferences);
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
