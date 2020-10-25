


import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'VerificationMobile.dart';
import 'VerificationTablet.dart';


class VerificationView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: VerificationMobile(),
      tablet: VerificationTablet(),
    );
  }
}