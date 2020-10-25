



import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'PaymentDetailsMobile.dart';
import 'PaymentDetailsTablet.dart';


class PaymentDetailsView extends StatelessWidget {
  PaymentDetailsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: PaymentDetailsMobile(),
      tablet: PaymentDetailsTablet(),
    );
  }
}