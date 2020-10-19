

import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/model/core/AppBookingApplication.dart';
import 'package:ds_book_app/app/model/core/AppComponent.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum EnvType {
  DEVELOPMENT,
  STAGING,
  PRODUCTION
}

class Env {

  static Env value;

  String appName;
  String baseUrl;

  EnvType environmentType = EnvType.DEVELOPMENT;

  Color primaryColor = Color(ColorUtils.hexToInt('#FFFFFF'));
  Color secondaryColor = Color(ColorUtils.hexToInt('#D65653'));
  MaterialColor primarySwatch = MaterialColor(0xFFD65653, {50:  Color(0xFFD65653), 100: Color(0xFFD65653), 200: Color(0xFFD65653), 300: Color(0xFFD65653),
    400: Color(0xFFD65653), 500: Color(0xFFD65653), 600: Color(0xFFD65653), 700: Color(0xFFD65653), 800: Color(0xFFD65653), 900: Color(0xFFD65653),});

  String loadingAnimaion = 'assets/json/loading.json';

  // Database Config
  int dbVersion = 1;
  String dbName;


  Env() {
    value = this;
    _init();
  }

  void _init() async{
    WidgetsFlutterBinding.ensureInitialized();
    var application = AppBookingApplication();
    await application.onCreate();
    runApp(AppComponent(application));
  }
}