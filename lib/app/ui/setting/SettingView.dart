



import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'SettingMobile.dart';
import 'SettingTablet.dart';



class SettingView extends StatelessWidget {
  SettingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: SettingMobile(),
      tablet: SettingTablet(),
    );
  }
}