


import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'GuestsMobile.dart';
import 'GuestsTablet.dart';


class GuestsView extends StatelessWidget {
  GuestsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: GuestsMobile(),
      tablet: GuestsTablet(),
    );
  }
}