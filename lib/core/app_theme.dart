import 'package:flutter/material.dart';

const primaryColor = Colors.purple;
final apptheme = ThemeData(
  primarySwatch: Colors.purple,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.purple),
    ),
  ),
);
