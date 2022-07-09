import 'package:clean_architicture_ecommerce/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:clean_architicture_ecommerce/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is SuccessLogoutState) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
          Phoenix.rebirth(context);
        }
      },
      builder: (context, state) {
        if (state is LoadingLogoutState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ElevatedButton.icon(
            onPressed: () {
              BlocProvider.of<LogoutBloc>(context).add(pressLogOutEvent());
            },
            icon: const Icon(Icons.logout),
            label: Text(AppLocalizations.of(context)!.log_out));
      },
    );
  }
}
