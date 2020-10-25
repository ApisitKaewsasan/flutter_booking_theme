

import 'package:ds_book_app/app/ui/OrientationLayout.dart';
import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'CancelledMobile.dart';
import 'CancelledTablet.dart';




class CancelledView extends StatelessWidget {
  CancelledView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: CancelledMobile(),
      tablet: CancelledTablet(),
    );
  }
}