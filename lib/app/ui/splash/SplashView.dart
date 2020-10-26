

import 'package:ds_book_app/app/ui/OrientationLayout.dart';
import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'SplashMobile.dart';
import 'SplashTablet.dart';

class SplashView extends StatelessWidget {
  SplashView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: SplashMobile(),
      tablet: SplashTablet(),
    );
  }
}