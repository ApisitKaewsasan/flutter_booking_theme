



import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'ChangePasswordMobile.dart';
import 'ChangePasswordTablet.dart';




class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: ChangePasswordMobile(),
      tablet: ChangePasswordTablet(),
    );
  }
}