

import 'dart:async';

import 'package:ds_book_app/app/model/core/AppBookingApplication.dart';
import 'package:ds_book_app/app/model/pojo/Checkin.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:easy_localization/easy_localization.dart';

class Check_Bloc{
  final AppBookingApplication _application;
  final _feedcheck = BehaviorSubject<List<Checkin>>();
  final  install_date_now = "${DateFormat("yyyy-MM-dd").format(DateTime.now())} 23:59:59";

  DateTime selectedPeriodStart;
  DateTime selectedPeriodEnd;
  String total = "0 ${LocaleKeys.mybooking_night.tr()}";

  Check_Bloc(this._application) {
    _init();
  }

  Stream<List<Checkin>> get feedList => _feedcheck.stream;

  Future<void> _init() async {
    // Debounce search text
    selectedPeriodStart  = DateTime.parse(install_date_now);
    selectedPeriodEnd = DateTime.parse(install_date_now);
    int count = await _application.dbAppStoreRepository.CountChecks();
    if (count == 0) {
      _application.dbAppStoreRepository.Insert_Date_Check(Checkin(id: 1,checkin: "${install_date_now}",checkout: "${install_date_now}"));
    }

  }
  CompositeSubscription _compositeSubscription = CompositeSubscription();

  void dispose() {
    _feedcheck.close();
    _compositeSubscription.clear();
  }



  loadFeedList() async {
    StreamSubscription subscription =
    Observable.fromFuture(_application.dbAppStoreRepository.get_Date_Check())
        .listen((List<Checkin> item) {

      //appList.add(event[0].children_count);


      if(DateTime.now().isAfter(DateTime.parse(item[0].checkin))){
        _application.dbAppStoreRepository.Update_Date_Check(Checkin(id: 1,checkin: "${install_date_now}",checkout: "${install_date_now}"));

      }

      _feedcheck.add(item);


    }, onError: (e, s) {
      Log.info(e);
      //_isShowLoading.add(false);
    });
    _compositeSubscription.add(subscription);
  }

  saveCheckin(DatePeriod _selectedPeriod){
    _application.dbAppStoreRepository.Update_Date_Check(Checkin(id: 1,checkin: "${DateFormat("yyyy-MM-dd").format(_selectedPeriod.start)} 23:59:59",checkout: "${_selectedPeriod.end}"));
    loadFeedList();
  }

}