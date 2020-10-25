

import 'package:ds_book_app/app/ui/OrientationLayout.dart';
import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'UnpaidMobile.dart';
import 'UnpaidTablet.dart';



class UnpaidView extends StatelessWidget {
  UnpaidView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: UnpaidMobile(),
      tablet: UnpaidTablet(),
    );
  }
}