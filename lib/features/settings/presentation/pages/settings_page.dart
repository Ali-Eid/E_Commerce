import '../../../../core/widget/no_intenet_widget.dart';

import '../../../../core/constants.dart';
import '../bloc/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/setting_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is LoadedProfileState) {
          return SettingWidget(
            profile: state.profile,
          );
        } else if (state is LoadingProfileState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is OfflineProfileState) {
          return RefreshIndicator(
            onRefresh: () async {
              return BlocProvider.of<ProfileBloc>(context)
                  .add(GetProfileEvent());
            },
            child: ErrorConnectionWidget(
                text: state.message, pathImg: 'assets/images/nointernet.json'),
          );
        } else if (state is ErrorProfileState) {
          return RefreshIndicator(
            onRefresh: () async {
              return BlocProvider.of<ProfileBloc>(context)
                  .add(GetProfileEvent());
            },
            child: ErrorConnectionWidget(
                text: state.message, pathImg: 'assets/images/serverError.json'),
          );
        }
        return const Text('');
      },
    );
  }
}
