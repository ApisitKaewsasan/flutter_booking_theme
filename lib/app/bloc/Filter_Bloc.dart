import 'dart:async';

import 'package:ds_book_app/app/model/core/AppBookingApplication.dart';
import 'package:ds_book_app/app/model/pojo/Filter.dart';
import 'package:ds_book_app/app/model/pojo/Sort.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:rxdart/rxdart.dart';

class Filter_bloc {
  final AppBookingApplication _application;


  //  var BehaviorSubject
  final _feedfilter = BehaviorSubject<Filter>();
  final _countfilter = BehaviorSubject<int>();
  final _sortlist = BehaviorSubject<int>();


//  var Stream
  Stream<int> get sortlist => _sortlist.stream;
  Stream<Filter> get feedList => _feedfilter.stream;
  Stream<int> get countfilter => _countfilter.stream;
  List<Filter> filter_backup = List<Filter>();


  //  var CompositeSubscription
  CompositeSubscription _compositeSubscription = CompositeSubscription();

  Filter_bloc(this._application) {
    _init();
  }


   // install function
  Future<void> _init() async {
    if (await _application.dbAppStoreRepository.CountFilter() == 0) {
      _application.dbAppStoreRepository.Insert_Room_Filter(instalData());
    }
    if(await _application.dbAppStoreRepository.CountSort()==0){
      _application.dbAppStoreRepository.Insert_Sort(Sort(id: 1,sort: 0));
    }
    checkcountFilter();
    loadSort();
    loadFeedList();
  }

  Filter instalData() {
    return Filter(
        id: 1,
        startwo: 0,
        starthee: 0,
        starone: 0,
        floorfour: 0,
        floorthee: 0,
        floortwo: 0,
        floorone: 0,
        cabletv: 0,
        parking: 0,
        wifi: 0,
        swimming: 0,
        superdeluxe: 0,
        deluxe: 0,
        double: 0,
        single: 0,
        starfour: 0);
  }

  void dispose() {
    _feedfilter.close();
    _compositeSubscription.clear();
  }

  loadFeedList() async {
    StreamSubscription subscription =
    Observable.fromFuture(_application.dbAppStoreRepository.getFilter())
        .listen((List<Filter> item) {
      if (filter_backup.length == 0) {
        filter_backup.addAll(item);
      }

      if (item.length > 0) {
        _feedfilter.add(item[0]);
      }
    }, onError: (e, s) {
      Log.info(e);
      //_isShowLoading.add(false);
    });
    _compositeSubscription.add(subscription);
  }

  checkcountFilter() {
    StreamSubscription subscription =
    Observable.fromFuture(_application.dbAppStoreRepository.getFilter())
        .listen((List<Filter> item) {
      var count_temp = 0;
      if (item.length > 0) {
        Filter data = item[0];
        count_temp +=
            data.single + data.double + data.deluxe + data.superdeluxe +
                data.swimming + data.wifi + data.parking + data.cabletv +
                data.floorone + data.floortwo + data.floorthee +
                data.floorfour + data.starone + data.startwo + data.starthee +
                data.starfour;
      }
      _countfilter.value = count_temp;
    }, onError: (e, s) {
      Log.info(e);
      //_isShowLoading.add(false);
    });
    _compositeSubscription.add(subscription);
  }

  loadSort(){
    StreamSubscription subscription =
    Observable.fromFuture(_application.dbAppStoreRepository.getSort())
        .listen((List<Sort> item) {

      _sortlist.value = item[0].sort;


    }, onError: (e, s) {
      Log.info(e);
      //_isShowLoading.add(false);
    });
    _compositeSubscription.add(subscription);
  }

  saveFilter(Filter filter) {
    _application.dbAppStoreRepository.Update_Date_Filter(filter);
  }

  updateFilter(String val, int num) {
    _application.dbAppStoreRepository.Update_Date_Filter_By_Id(val, num);
    loadFeedList();
  }

  resetFilter() {
    _application.dbAppStoreRepository.DeleteFilter().then((value) {
      _application.dbAppStoreRepository
          .Insert_Room_Filter(instalData())
          .then((value) {
        loadFeedList();
      });
    });
  }

  deleteFilter() {
    _application.dbAppStoreRepository.DeleteFilter().then((value) {
      _application.dbAppStoreRepository.Insert_Room_Filter(filter_backup[0]);
    });
  }

  updateSort(int num){
    _application.dbAppStoreRepository.Update_Sort(Sort(id: 1,sort: num));
    loadSort();
  }
}
