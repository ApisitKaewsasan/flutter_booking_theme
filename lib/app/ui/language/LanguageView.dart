



import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'LanguageMobile.dart';
import 'LanguageTablet.dart';



class LanguageView extends StatelessWidget {
  LanguageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: LanguageMobile(),
      tablet: LanguageTablet(),
    );
  }
}