



import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'ConfirmPaymentMobile.dart';
import 'ConfirmPaymentTablet.dart';



class ConfirmPaymentView extends StatelessWidget {
  ConfirmPaymentView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: ConfirmPaymentMobile(),
      tablet: ConfirmPaymentTablet(),
    );
  }
}