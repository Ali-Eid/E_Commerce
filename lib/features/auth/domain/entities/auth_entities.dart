import 'package:equatable/equatable.dart';

class AuthEntities extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  var points;
  var credit;
  final String token;

  AuthEntities(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.image,
      required this.points,
      required this.credit,
      required this.token});

  @override
  List<Object?> get props =>
      [id, name, email, phone, image, points, credit, token];
}
