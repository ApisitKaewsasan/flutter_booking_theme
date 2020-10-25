


import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'TransfertoMobile.dart';
import 'TransfertoTablet.dart';



class TransfertoView extends StatelessWidget {
  final title_val;

  TransfertoView({Key key, this.title_val}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: TransfertoMobile(title_val: title_val),
      tablet: TransfertoTablet(title_val: title_val),
    );
  }
}