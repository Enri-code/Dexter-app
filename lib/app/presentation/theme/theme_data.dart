import 'package:dexter_test/app/presentation/theme/buttons.dart';
import 'package:dexter_test/app/presentation/theme/text.dart';
import 'package:flutter/material.dart';

class LightThemeBuilder {
  final Color primaryColor;
  LightThemeBuilder(this.primaryColor)
      : buttonTheme = WidgetsThemeData(primaryColor: primaryColor) {
    theme = ThemeData.from(
      colorScheme: ColorScheme.light(primary: primaryColor),
      textTheme: MyTextData.textTheme,
    ).copyWith(
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      textButtonTheme: buttonTheme.textButtonTheme,
      elevatedButtonTheme: buttonTheme.elevatedButtonTheme,
      outlinedButtonTheme: buttonTheme.outlinedButtonTheme,
      inputDecorationTheme: WidgetsThemeData.inputDecorationTheme,
    );
  }
  final WidgetsThemeData buttonTheme;
  late final ThemeData theme;
}
