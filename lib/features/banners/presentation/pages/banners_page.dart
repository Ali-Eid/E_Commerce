import '../bloc/banners/banners_bloc.dart';
import '../widgets/banners_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannersPage extends StatelessWidget {
  const BannersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersBloc, BannersState>(
      builder: (context, state) {
        if (state is SuccessgetImgBannersImgStates) {
          return BannersWidget(banners: state.banners.data!);
        }
        return const Center(
          child: LinearProgressIndicator(),
        );
      },
    );
  }
}
