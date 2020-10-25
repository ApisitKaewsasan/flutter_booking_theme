

import 'package:ds_book_app/app/ui/OrientationLayout.dart';
import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'MyBookingMobile.dart';
import 'MyBookingTablet.dart';



class MyBookingView extends StatelessWidget {
  MyBookingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MyBookingMobile(),
      tablet: MyBookingTablet(),
    );
  }
}