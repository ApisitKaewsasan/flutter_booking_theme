



import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'MySaveMobile.dart';
import 'MySaveTablet.dart';



class MySaveView extends StatelessWidget {
  MySaveView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MySaveMobile(),
      tablet: MySaveTablet(),
    );
  }
}