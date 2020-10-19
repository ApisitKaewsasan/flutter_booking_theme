


import 'package:ds_book_app/app/model/core/AppBookingApplication.dart';
import 'package:ds_book_app/app/model/core/Usermanager.dart';

import 'package:flutter/material.dart';

class AppProvider extends InheritedWidget {

  final AppBookingApplication application;

  AppProvider({Key key, Widget child, this.application})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static AppProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider);
  }


  static AppBookingApplication getApplication(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider).application;
  }



}
