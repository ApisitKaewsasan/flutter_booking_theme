import 'dart:async';
import 'dart:developer';

import 'package:ds_book_app/app/model/core/AppBookingApplication.dart';
import 'package:ds_book_app/app/model/pojo/Guests.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:rxdart/rxdart.dart';

class Guests_Bloc {
  final AppBookingApplication _application;
  List<Guests> guests_backup = List<Guests>();

  //  var BehaviorSubject
  final _feedList = BehaviorSubject<List<Guests>>();


  //  var Stream
  Stream<List<Guests>> get feedList => _feedList.stream;


  //  var CompositeSubscription
  CompositeSubscription _compositeSubscription = CompositeSubscription();



  // install function
  Future<void> _init() async {
    int count = await _application.dbAppStoreRepository.CountGuests();
    if (count == 0) {
      _application.dbAppStoreRepository
          .Insert_Room_Guests(Guests(adults_count: 0, children_count: 0));
    }
    loadFeedList();
  }


  Guests_Bloc(this._application) {
    _init();
  }


  void dispose() {
    _feedList.close();
    _compositeSubscription.clear();
  }

  loadFeedList() async {
    StreamSubscription subscription =
        Observable.fromFuture(_application.dbAppStoreRepository.getGuests())
            .listen((List<Guests> item) {

          //appList.add(event[0].children_count);
          if(guests_backup.length==0){
            guests_backup.addAll(item);
          }

          _feedList.add(item);

        }, onError: (e, s) {
      Log.info(e);
      //_isShowLoading.add(false);
    });
    _compositeSubscription.add(subscription);
  }

  SelectAdults_Count(int id,int num){
    _application.dbAppStoreRepository.AdultsAdd(id, num).then((value) => loadFeedList());
  }

  SelectChildren_Count(int id,int num){
    _application.dbAppStoreRepository.ChildrenAdd(id, num).then((value) => loadFeedList());
  }

  void Remove_Room(int id) {
    _application.dbAppStoreRepository.deleteRoom_Guests(id).then((value) => loadFeedList());
  }

  void Add_Guests() {
    _application.dbAppStoreRepository.Insert_Room_Guests(Guests(adults_count: 0, children_count: 0)).then((value) => loadFeedList());
  }

  void DeleteAllRoom(){
    _application.dbAppStoreRepository.DeleteAllRoom().then((value){
      //loadFeedList();
      for (var i = 0; i < guests_backup.length; i++) {
        _application.dbAppStoreRepository.Insert_Room_Guests(Guests(adults_count: guests_backup[i].adults_count, children_count: guests_backup[i].children_count));
      }
    });


  }
}
