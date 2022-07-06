part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {}

class updateProfileEvent extends ProfileEvent {
  // final String name;
  // final String email;
  // final String phone;
  final ProfileEntitiy profile;

  const updateProfileEvent({required this.profile});
}
