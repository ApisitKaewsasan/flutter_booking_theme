

import 'package:ds_book_app/app/ui/OrientationLayout.dart';
import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'CompletedMobile.dart';
import 'CompletedTablet.dart';



class CompletedView extends StatelessWidget {
  CompletedView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: CompletedMobile(),
      tablet: CompletedTablet(),
    );
  }
}