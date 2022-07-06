import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalCategoryDataSource {
  Future<String> getcachedLang();
}

class LocalCategoryDataSourceImpl implements LocalCategoryDataSource {
  final SharedPreferences sharedPreferences;

  LocalCategoryDataSourceImpl(this.sharedPreferences);
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
