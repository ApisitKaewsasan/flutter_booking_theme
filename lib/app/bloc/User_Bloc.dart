
import 'dart:async';

import 'package:ds_book_app/app/model/core/AppBookingApplication.dart';
import 'package:ds_book_app/app/model/core/Usermanager.dart';
import 'package:ds_book_app/app/model/pojo/response/User.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:rxdart/rxdart.dart';

class User_Bloc{
  final AppBookingApplication _application;
  final _feeduser = BehaviorSubject<User>();


  Stream<User> get getUser => _feeduser.stream;

  CompositeSubscription _compositeSubscription = CompositeSubscription();

  User_Bloc(this._application){
    _init();
  }


  Future<void> _init() async {
    loadUser();
  }


  void dispose() {
    _feeduser.close();
    _compositeSubscription.clear();
  }


  loadUser() async {
    _feeduser.add(await Usermanager().getUser());
  }



}