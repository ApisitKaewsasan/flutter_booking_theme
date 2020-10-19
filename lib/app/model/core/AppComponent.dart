

import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/model/core/AppBookingApplication.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/Usermanager.dart';
import 'package:ds_book_app/app/ui/page/SplashPage.dart';
import 'package:ds_book_app/app/ui/page/StartUpPage.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();


class AppComponent extends StatefulWidget {

  final AppBookingApplication _application;

  AppComponent(this._application);

  @override
  State createState() {
    return new AppComponentState(_application);
  }
}

class AppComponentState extends State<AppComponent> {

  final AppBookingApplication _application;

  AppComponentState(this._application);

  @override
  void dispose()async{
    Log.info('dispose');
    super.dispose();
    await _application.onTerminate();
  }

  @override
  Widget build(BuildContext context) {

    final app = new MaterialApp(
      title: Env.value.appName,
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: Env.value.primarySwatch,snackBarTheme: SnackBarThemeData(contentTextStyle: GoogleFonts.kanit()),primaryColor: Color(ColorUtils.hexToInt('#FFFFFF')),
      ),
      home: SplashPage(),
      navigatorObservers: [routeObserver],
    );

    final appProvider = AppProvider(child: app, application: _application);
    return appProvider;
  }
}