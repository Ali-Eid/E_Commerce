part of 'localization_bloc.dart';

abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class SetLocalEvent extends LocalizationEvent {
  final String locale;
  const SetLocalEvent({required this.locale});

  @override
  List<Object> get props => [locale];
}
