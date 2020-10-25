



import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'PaymentMobile.dart';
import 'PaymentTablet.dart';


class PaymentView extends StatelessWidget {

  final id;
  final titiletag;
  final imagetag;

  const PaymentView({Key key, this.id = "0", this.titiletag, this.imagetag})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: PaymentMobile(id: id,titiletag: titiletag,imagetag: imagetag),
      tablet: PaymentTablet(id: id,titiletag: titiletag,imagetag: imagetag),
    );
  }
}