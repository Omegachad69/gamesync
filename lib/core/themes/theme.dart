import 'package:flutter/material.dart';
import 'package:gameync/core/themes/app_pallete.dart';

class AppTheme {
  static _border([Color color = Colors.blueAccent]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(27),
      borderSide: BorderSide(color: color, width: 3));
  static final darkThemeMode = ThemeData.dark().copyWith(
      appBarTheme:
          const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
      chipTheme: const ChipThemeData(
          color: MaterialStatePropertyAll(AppPallete.backgroundColor),
          side: BorderSide.none),
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(27),
          enabledBorder: _border(Colors.blueGrey.withOpacity(0.1)),
          focusedBorder: _border(AppPallete.gradient2),
          errorBorder: _border(AppPallete.errorColor),
          border: _border(),
          fillColor: Colors.white));
}
