

import 'package:ds_book_app/app/ui/OrientationLayout.dart';
import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'BookedMobile.dart';
import 'BookedTablet.dart';



class BookedView extends StatelessWidget {
  BookedView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: BookedMobile(),
      tablet: BookedTablet(),
    );
  }
}