import '../../data/models/banners_model.dart';
import 'package:equatable/equatable.dart';

class BannersEntities extends Equatable {
  List<DataBanners>? data;
  BannersEntities({this.data});

  @override
  List<Object?> get props => [data];
}
