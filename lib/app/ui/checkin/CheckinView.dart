


import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'CheckinMobile.dart';
import 'CheckinTablet.dart';



class CheckinView extends StatelessWidget {
  CheckinView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: CheckinMobile(),
      tablet: CheckinTablet(),
    );
  }
}