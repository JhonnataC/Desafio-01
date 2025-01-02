import 'package:flutter/material.dart';

class AppColors {
  static const white1 = Color(0XFFFFFFFF);
  static const white2 = Color(0XFFF7F7F7);
  static const purple1 = Color(0XFF878AF5);
  static const purple2 = Color(0XFF666AF6);
  static const green = Color(0XFF9EF5CF);
  static const black = Color(0XFF2B282A);
  static const grey = Color(0XFF31446C);

  static final lightColorScheme = ThemeData().colorScheme.copyWith(
        primary: purple1,
        onPrimary: white1,
        secondary: purple2,
        onSecondary: white1,
        tertiary: white2,
        surface: white1,
      );

  static final darkColorScheme = ThemeData().colorScheme.copyWith();
}
