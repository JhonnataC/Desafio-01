import 'package:flutter/material.dart';

class AppColors {
  static const white = Color(0XFFFFFFFF);
  static const white2 = Color(0XFFF7F7F7);
  static const green = Color(0XFF12B57A);
  static const black = Color(0XFF171719);
  static const black2 = Color(0XFF2B282A);
  static const grey = Color(0XFF232229);
  static const grey2 = Color(0XFF4E4B53);
  static const blue = Color(0XFF3067DF);
  static const blue2 = Color(0XFF3067DF);
  static const red = Color(0XFFF44336);

  static final darkColorScheme = ThemeData().colorScheme.copyWith(
        primary: black,
        onPrimary: white,
        secondary: blue,
        onSecondary: white,
        surface: grey,
        onSurface: grey2,
        error: red,
        tertiary: green,
      );

  static final ligthColorScheme = ThemeData().colorScheme.copyWith();
}
