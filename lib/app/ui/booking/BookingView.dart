

import 'package:ds_book_app/app/ui/OrientationLayout.dart';
import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'BookingMobile.dart';
import 'BookingTablet.dart';



class BookingView extends StatelessWidget {
  final titiletag;
  final imagetag;
  BookingView({Key key, this.titiletag, this.imagetag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: BookingMobile(titiletag: titiletag,imagetag: imagetag),
      tablet: BookingTablet(titiletag: titiletag,imagetag: imagetag),
    );
  }
}