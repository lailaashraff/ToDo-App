import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLightColor = Color(0xff5D9CEC);
  static Color primaryLightBgColor = Color(0xffDFECDB);
  static Color whiteColor = Color(0xffFFFFFF);
  static Color blackColor = Color(0xff363636);
  static Color redColor = Color(0xffEC4B4B);
  static Color greenColor = Color(0xff61E757);
  static Color grayColor = Color(0xffC8C9CB);
  static Color darkBlackColor = Color(0xff383838);
  static Color primaryDarkColor=Color(0xff060E1E);
  static Color navy=Color(0xff141922);



  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryLightColor,
    scaffoldBackgroundColor: primaryLightBgColor,
    appBarTheme: AppBarTheme(
      color: primaryLightColor,

    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: whiteColor
      ),
      titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: primaryLightColor
      ),
        titleSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: MyTheme.blackColor
        ),
        bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: MyTheme.blackColor
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryLightColor,
      elevation: 0

    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: StadiumBorder(
        side: BorderSide(
            width: 4,
            color: whiteColor
        ),

      ),
      backgroundColor: primaryLightColor,
      foregroundColor: whiteColor
    ),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryDarkColor,
    scaffoldBackgroundColor: primaryDarkColor,
    appBarTheme: AppBarTheme(
      color: primaryLightColor,

    ),
    textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: primaryDarkColor
        ),
        titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: primaryLightColor
        ),
        titleSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: MyTheme.whiteColor
        ),
        bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: MyTheme.whiteColor
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: navy,
        elevation: 0

    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: StadiumBorder(
          side: BorderSide(
              width: 4,
              color: navy
          ),

        ),
        backgroundColor: primaryLightColor,
        foregroundColor: whiteColor
    ),
  );
}