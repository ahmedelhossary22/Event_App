import 'package:event_app/core/theme/color_pallate.dart';
import 'package:event_app/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

abstract class AppThemeManger {
  static ThemeData lightTheme = ThemeData(
    datePickerTheme: DatePickerThemeData(
      backgroundColor: ColorPallate.scaffoldBackGroundColor,
    ),
    scaffoldBackgroundColor: ColorPallate.scaffoldBackGroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorPallate.primaryColor),
      titleTextStyle: TextStyle(
        fontFamily: FontFamily.inter,
        fontWeight: FontWeight.w600,
        fontSize: 22,
        color: ColorPallate.primaryColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorPallate.primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),

    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontFamily: FontFamily.inter,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontFamily: FontFamily.inter,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: FontFamily.inter,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontFamily: FontFamily.inter,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: FontFamily.inter,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: FontFamily.inter,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: FontFamily.inter,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorPallate.darkScaffoldBackGroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorPallate.darkScaffoldBackGroundColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),
  );
}
