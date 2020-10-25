



import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'ForgetPasswordMobile.dart';
import 'ForgetPasswordTablet.dart';



class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: ForgetPasswordMobile(),
      tablet: ForgetPasswordTablet(),
    );
  }
}