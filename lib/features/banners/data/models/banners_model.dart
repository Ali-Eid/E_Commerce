import '../../domain/entities/banners_entities.dart';
import 'package:flutter/cupertino.dart';

class bannersModel extends BannersEntities {
  @override
  List<DataBanners>? data;

  bannersModel({this.data});

  bannersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataBanners>[];
      json['data'].forEach((v) {
        data!.add(DataBanners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataBanners {
  int? id;
  String? image;
  var category;
  var product;

  DataBanners({this.id, this.image, this.category, this.product});

  DataBanners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['category'] = category;
    data['product'] = product;
    return data;
  }
}
