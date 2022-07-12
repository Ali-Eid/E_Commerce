part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class LoadedProfileState extends ProfileState {
  final ProfileEntitiy profile;

  const LoadedProfileState({required this.profile});
}

class ErrorProfileState extends ProfileState {
  final String message;

  const ErrorProfileState({required this.message});
}

class OfflineProfileState extends ProfileState {
  final String message;

  const OfflineProfileState({required this.message});
}

//----------------update profile
class LoadingupdateProfileState extends ProfileState {}

class LoadedupdateProfileState extends ProfileState {
  final ProfileEntitiy profile;

  const LoadedupdateProfileState({required this.profile});
}

class ErrorupdateProfileState extends ProfileState {
  final String message;

  const ErrorupdateProfileState({required this.message});
}

//change profile photo

class uploadPhotoProfileState extends ProfileState {
  // final String photo;

  // const uploadPhotoProfileState({required this.photo});
}

class ErroruploadPhotoProfileState extends ProfileState {
  // final String message;

  // const ErroruploadPhotoProfileState({required this.message});
}
