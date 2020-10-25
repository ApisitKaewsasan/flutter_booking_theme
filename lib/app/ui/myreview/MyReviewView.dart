



import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'MyReviewMobile.dart';
import 'MyReviewTablet.dart';



class MyReviewView extends StatelessWidget {
  MyReviewView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MyReviewMobile(),
      tablet: MyReviewTablet(),
    );
  }
}