import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalProductDataSource {
  Future<String> getcachedLang();
}

class localProductDataSourceImpl implements LocalProductDataSource {
  final SharedPreferences sharedPreferences;

  localProductDataSourceImpl(this.sharedPreferences);
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
