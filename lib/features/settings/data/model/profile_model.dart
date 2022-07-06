import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntitiy {
  ProfileModel({
    required int id,
    required String name,
    required String email,
    required var phone,
    required String image,
    required var points,
    required var credit,
    required String token,
  }) : super(
          id: id,
          name: name,
          email: email,
          image: image,
          phone: phone,
          credit: credit,
          points: points,
          token: token,
        );

  factory ProfileModel.fromjson(Map<String, dynamic> json) {
    return ProfileModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        image: json['image'],
        points: json['points'],
        credit: json['credit'],
        token: json['token']);
  }

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'points': points,
      'credit': credit,
      'token': token,
    };
  }
}
