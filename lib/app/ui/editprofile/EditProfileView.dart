

import 'package:ds_book_app/app/ui/OrientationLayout.dart';
import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'EditProfileMobile.dart';
import 'EditProfileTablet.dart';



class EditProfileView extends StatelessWidget {
  EditProfileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: EditProfileMobile(),
      tablet: EditProfileTablet(),
    );
  }
}