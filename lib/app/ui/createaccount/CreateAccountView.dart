



import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'CreateAccountMobile.dart';
import 'CreateAccountTablet.dart';


class CreateAccountView extends StatelessWidget {
  CreateAccountView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: CreateAccountMobile(),
      tablet: CreateAccountTablet(),
    );
  }
}