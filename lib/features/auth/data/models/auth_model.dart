import '../../domain/entities/auth_entities.dart';

class AuthModel extends AuthEntities {
  AuthModel({
    required int? id,
    required String? name,
    required String? email,
    required String? phone,
    required String? image,
    required var points,
    required var credit,
    required String token,
  }) : super(
          id: id,
          name: name,
          email: email,
          phone: phone,
          image: image,
          points: points,
          credit: credit,
          token: token,
        );

  factory AuthModel.fromjson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      points: json['points'],
      credit: json['credit'],
      token: json['token'],
    );
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
