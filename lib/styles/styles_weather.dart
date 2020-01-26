import 'dart:ui';

import 'package:flutter/material.dart';

const Color colorPrimaryDark = Color(0xFF31343d);
const Color colorDark = Color(0xFF353841);
const Color colorPrimaryLight = Color(0xFFb6b6c0);
const Color colorLight = Color(0xFFe8e8f2);

const TextTheme textTheme =
    TextTheme(title: TextStyle(fontSize: 16), body1: TextStyle(fontSize: 14));
const TextTheme primaryTextTheme =
    TextTheme(title: TextStyle(fontSize: 16), body1: TextStyle(fontSize: 14));

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: colorPrimaryDark,
  backgroundColor: colorDark,
  accentColor: colorPrimaryLight,
  accentIconTheme: const IconThemeData(color: colorPrimaryDark),
  textTheme: textTheme.apply(
    bodyColor: colorLight,
    displayColor: colorLight,
  ),
  primaryTextTheme: primaryTextTheme.apply(
      bodyColor: colorPrimaryLight, displayColor: colorPrimaryLight),
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  backgroundColor: Colors.white,
  accentColor: colorPrimaryDark,
  accentIconTheme: const IconThemeData(color: colorPrimaryLight),
  textTheme: textTheme.apply(
    bodyColor: colorDark,
    displayColor: colorDark,
  ),
  primaryTextTheme: primaryTextTheme.apply(
      bodyColor: colorPrimaryDark, displayColor: colorPrimaryDark),
);
