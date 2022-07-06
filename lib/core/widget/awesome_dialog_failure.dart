import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clean_architicture_ecommerce/core/app_theme.dart';
import 'package:flutter/material.dart';

AwesomeDialog getDialogFailure(
    {required BuildContext context, required String msg}) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.ERROR,
    headerAnimationLoop: true,
    animType: AnimType.TOPSLIDE,
    title: 'Failure',
    desc: msg,
    buttonsTextStyle: const TextStyle(color: Colors.white),
    showCloseIcon: true,
    btnOkColor: primaryColor,
    btnOkOnPress: () {},
  );
}
