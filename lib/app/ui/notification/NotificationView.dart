



import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'NotificationMobile.dart';
import 'NotificationTablet.dart';





class NotificationView extends StatelessWidget {
  NotificationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NotificationMobile(),
      tablet: NotificationTablet(),
    );
  }
}