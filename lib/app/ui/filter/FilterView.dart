



import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'FilterMobile.dart';
import 'FilterTablet.dart';

class FilterView extends StatelessWidget {
  FilterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: FilterMobile(),
      tablet: FilterTablet(),
    );
  }
}