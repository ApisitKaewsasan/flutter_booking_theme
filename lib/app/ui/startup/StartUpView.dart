


import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'StartUpMobile.dart';
import 'StartUpTablet.dart';

class StartUpView extends StatelessWidget {
  StartUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: StartUpMobile(),
      tablet: StartUpTablet(),
    );
  }
}