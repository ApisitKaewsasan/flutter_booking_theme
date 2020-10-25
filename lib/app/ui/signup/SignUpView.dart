


import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'SignUpMobile.dart';
import 'SignUpTablet.dart';



class SignUpView extends StatelessWidget {
  SignUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: SignUpMobile(),
      tablet: SignUpTablet(),
    );
  }
}