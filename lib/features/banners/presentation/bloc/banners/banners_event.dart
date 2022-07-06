part of 'banners_bloc.dart';

abstract class BannersEvent extends Equatable {
  const BannersEvent();

  @override
  List<Object> get props => [];
}

class getAllBannersImgEvent extends BannersEvent {}
