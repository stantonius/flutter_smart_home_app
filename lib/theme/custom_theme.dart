import 'package:flutter/material.dart';

import 'custom_colours.dart';

// taken from https://www.raywenderlich.com/16628777-theming-a-flutter-app-getting-started#toc-anchor-005

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: CustomColours.mainPurple),
        scaffoldBackgroundColor: CustomColours.background,
        primaryColor: CustomColours.accentPurple,
        colorScheme: ColorScheme.light(),
        // ColorScheme(
        //   primary: CustomColours.mainPurple,
        //   primaryVariant: Colors.purple,
        //   secondary: CustomColours.accentPurple,
        //   secondaryVariant: Colors.purple,
        //   surface: CustomColours.background,
        //   background: CustomColours.background,
        //   error: CustomColours.error,
        // ),
        // switchTheme: SwitchThemeData(
        //   thumbColor: CustomColours.accentPurple,
        // ),
        cardTheme: CardTheme(
          color: Colors.white,
          shadowColor: CustomColours.accentPurple,
          margin: EdgeInsets.all(10),
          elevation: 5.0,
        ));
  }
}
