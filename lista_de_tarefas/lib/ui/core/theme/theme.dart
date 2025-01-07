import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/ui/core/theme/colors.dart';

class AppTheme {
  static final _textTheme = ThemeData().textTheme.copyWith(
        headlineLarge: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        headlineMedium: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 26,
        ),
        headlineSmall: const TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
        titleLarge: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        titleMedium: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
        titleSmall: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 15,
        ),
        bodyLarge: const TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
        bodyMedium: const TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 15,
        ),
        bodySmall: const TextStyle(
          color: AppColors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 12,
          color: Colors.white.withValues(alpha: 0.2),
        ),
        labelMedium: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 9,
          color: AppColors.white,
        ),        
      );

  static final _appBarTheme = ThemeData().appBarTheme.copyWith(
        titleTextStyle: const TextStyle(),
        color: AppColors.blue,
      );

  static ThemeData lightTheme = ThemeData().copyWith(
    colorScheme: AppColors.darkColorScheme,
    appBarTheme: _appBarTheme,
    textTheme: _textTheme,
  );
}
