part of 'banners_bloc.dart';

abstract class BannersState extends Equatable {
  const BannersState();

  @override
  List<Object> get props => [];
}

class BannersInitial extends BannersState {}

class LoadingBannersState extends BannersState {}

class SuccessgetImgBannersImgStates extends BannersState {
  final BannersEntities banners;

  const SuccessgetImgBannersImgStates({required this.banners});
}

class ErrorBannersState extends BannersState {
  final String message;

  const ErrorBannersState({required this.message});
}
