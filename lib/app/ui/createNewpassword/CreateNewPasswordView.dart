



import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'CreateNewPasswordMobile.dart';
import 'CreateNewPasswordTablet.dart';



class CreateNewPasswordView extends StatelessWidget {
  CreateNewPasswordView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: CreateNewPasswordMobile(),
      tablet: CreateNewPasswordTablet(),
    );
  }
}