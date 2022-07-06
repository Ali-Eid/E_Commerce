import 'package:bloc/bloc.dart';
import 'package:clean_architicture_ecommerce/core/error/failures/failures.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../domain/usecases/get_profile_usecase.dart';
import '../../../domain/usecases/update_profile.usecase.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfile;
  final UpdateProfileUseCase updateProfile;
  ProfileBloc({
    required this.getProfile,
    required this.updateProfile,
  }) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetProfileEvent) {
        emit(LoadingProfileState());
        final failureOrProfie = await getProfile();
        failureOrProfie.fold((failure) {
          emit(_mapFailureToState(failure));
        }, (profile) {
          emit(LoadedProfileState(profile: profile));
        });
      } else if (event is updateProfileEvent) {
        emit(LoadingupdateProfileState());
        final failureOrProfile = await updateProfile(profile: event.profile);
        failureOrProfile.fold((failure) {
          emit(_mapFailureToState(failure));
        }, (profile) {
          emit(
            LoadedupdateProfileState(profile: profile),
          );
        });
      }
    });
  }
  ProfileState _mapFailureToState(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return const ErrorProfileState(
            message: 'Server Error Please Try again Later . ');
      case OfflineFailure:
        return const OfflineProfileState(
            message: 'No internet Connection , please check your connection .');

      default:
        return const ErrorProfileState(
            message: 'Unexpected Error , please try again later .');
    }
  }
}
