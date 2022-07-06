part of 'localization_bloc.dart';

abstract class LocalizationState extends Equatable {
  final String local = 'en';
  const LocalizationState();

  @override
  List<Object> get props => [local];
}

class LocalizationInitial extends LocalizationState {
  @override
  String local = 'en';
  // const LocalizationInitial({required local});
  LocalizationInitial([this.local = 'en']);
  @override
  List<Object> get props => [local];
}

class ChangeLocalizationState extends LocalizationState {
  @override
  final String local = 'en';
  const ChangeLocalizationState({required local});
  @override
  List<Object> get props => [local];
}
