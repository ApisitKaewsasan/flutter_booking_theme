


import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'TransferMobile.dart';
import 'TransferTablet.dart';



class TransferfromView extends StatelessWidget {
  final title_val;

  TransferfromView({Key key, this.title_val}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: TransferMobile(title_val: title_val),
      tablet: TransferTablet(title_val: title_val),
    );
  }
}