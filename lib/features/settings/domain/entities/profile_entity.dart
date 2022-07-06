import 'package:equatable/equatable.dart';

class ProfileEntitiy extends Equatable {
  final int id;
  final String name;
  final String email;
  var phone;
  final String image;
  var points;
  var credit;
  final String token;

  ProfileEntitiy(
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
