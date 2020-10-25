

import 'package:ds_book_app/app/ui/OrientationLayout.dart';
import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'SelectRoomMobile.dart';
import 'SelectRoomTablet.dart';


class SelectRoomView extends StatelessWidget {
  SelectRoomView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: SelectRoomMobile(),
      tablet: SelectRoomTablet(),
    );
  }
}