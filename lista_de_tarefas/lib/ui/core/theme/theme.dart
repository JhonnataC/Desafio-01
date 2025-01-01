import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/ui/core/theme/colors.dart';

class AppTheme {
  static final _textTheme = ThemeData().textTheme.copyWith(
        headlineLarge: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 26,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w300,
          fontSize: 21,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 16,
        ),
      );

  static final _appBarTheme = ThemeData().appBarTheme.copyWith(
        titleTextStyle: TextStyle(),
        color: AppColors.purple1,
      );

  static ThemeData lightTheme = ThemeData().copyWith(
    colorScheme: AppColors.lightColorScheme,
    appBarTheme: _appBarTheme,
    textTheme: _textTheme,
  );
}
