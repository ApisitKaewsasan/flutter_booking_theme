

import 'package:ds_book_app/app/ui/OrientationLayout.dart';
import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'SignInMobile.dart';
import 'SignInTablet.dart';


class SignInView extends StatelessWidget {
  SignInView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: SignInMobile(),
      tablet: SignInTablet(),
    );
  }
}