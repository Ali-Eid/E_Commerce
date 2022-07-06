import '../L10n/l10n.dart';
import '../app_theme.dart';
import '../../features/settings/presentation/bloc/localization/localization_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    // final flag = L10n.getflag(locale.languageCode);
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: const SizedBox(
          // color: primaryColor,
          width: 12,
          child: Icon(
            Icons.language,
            color: primaryColor,
          ),
        ),
        items: L10n.all.map(
          (locale) {
            final flag = L10n.getflag(locale.languageCode);
            return DropdownMenuItem(
              child: Center(
                child: Text(
                  flag,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              value: locale,
              onTap: () {
                // BlocProvider.of<LocalizationBloc>(context)
                //     .add(SetLocalEvent(locale: locale));
              },
            );
          },
        ).toList(),
        onChanged: (value) {},
      ),
    );
  }
}
