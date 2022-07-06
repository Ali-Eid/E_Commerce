import '../repository/setting_repositroy.dart';

class SetLanguageUseCase {
  final SettingRepository repository;

  SetLanguageUseCase(this.repository);
  String call(String locale) {
    return repository.setLanguage(locale);
  }
}
