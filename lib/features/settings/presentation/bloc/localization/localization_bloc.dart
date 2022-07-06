import 'dart:math';

import 'package:bloc/bloc.dart';
import '../../../../../core/L10n/l10n.dart';
import '../../../domain/usecases/set_language.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final SetLanguageUseCase setLanguage;
  LocalizationBloc({required this.setLanguage}) : super(LocalizationInitial()) {
    on<LocalizationEvent>((event, emit) async {
      if (event is SetLocalEvent) {
        setLanguage(event.locale);
        // emit(ChangeLocalizationState(local: event.locale));
        // SharedPreferences.getInstance().then((value) {
        //   value.setString('lang', event.locale);
        // });
        emit(LocalizationInitial(event.locale));
      }
    });
  }
}
