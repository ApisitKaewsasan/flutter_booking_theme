

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeColor{

  static Color secondaryColor(BuildContext context){
    return Color(ColorUtils.hexToInt('#D65653'));
  }


  static Color ButtonColor(BuildContext context){
    return Color(ColorUtils.hexToInt('#FFFFFF'));
  }

  static Color primaryColor(BuildContext context){

    return MediaQuery.of(context).platformBrightness==Brightness.dark?Colors.black.withOpacity(1):Colors.white;
  }

  static Color fontprimaryColor(BuildContext context){
    return MediaQuery.of(context).platformBrightness==Brightness.dark?Colors.white:Colors.black;
  }

  static Color fontFadedColor(BuildContext context){
    return MediaQuery.of(context).platformBrightness==Brightness.dark?Colors.white:Color(ColorUtils.hexToInt('#707070'));
  }
  static Color suffixIconColor(BuildContext context){
    return MediaQuery.of(context).platformBrightness==Brightness.dark?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.2);
  }

  static Color hintTextColor(BuildContext context){
    return MediaQuery.of(context).platformBrightness==Brightness.dark?Colors.white.withOpacity(0.3):Colors.black.withOpacity(0.2);
  }

  static Color DialogHeaderprimary(BuildContext context){
    return MediaQuery.of(context).platformBrightness==Brightness.dark?Colors.black:Color(ColorUtils.hexToInt('#D65653'));
  }

  static Color FadedprimaryColor(BuildContext context){
    return MediaQuery.of(context).platformBrightness==Brightness.dark?Colors.white:Color(ColorUtils.hexToInt('#C5C5C5'));
  }

  static Color primarySwatch(BuildContext context){
    MaterialColor primarySwatch = MaterialColor(0xFFD65653, {
      50: Color(0xFFD65653),
      100: Color(0xFFD65653),
      200: Color(0xFFD65653),
      300: Color(0xFFD65653),
      400: Color(0xFFD65653),
      500: Color(0xFFD65653),
      600: Color(0xFFD65653),
      700: Color(0xFFD65653),
      800: Color(0xFFD65653),
      900: Color(0xFFD65653),
    });
    return primarySwatch;
  }

  static SnackBarThemeData SnackBarThemeColor(BuildContext context){
    return SnackBarThemeData(contentTextStyle: GoogleFonts.kanit(color: Colors.amber));
  }


  static Color DialogprimaryColor(BuildContext context){

    return MediaQuery.of(context).platformBrightness==Brightness.dark?Colors.black.withOpacity(0.4):Colors.white;
  }




}