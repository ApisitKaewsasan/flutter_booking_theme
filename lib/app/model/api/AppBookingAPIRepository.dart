

import 'package:dio/dio.dart';
import 'package:ds_book_app/app/model/api/APIProvider.dart';
import 'package:ds_book_app/app/model/db/DBBookingRepository.dart';
import 'package:ds_book_app/app/model/pojo/response/Task.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/http/HttpException.dart';
import 'package:ds_book_app/utility/log/DioLogger.dart';
import 'package:rxdart/rxdart.dart';

class AppBookingAPIRepository{
  static const String TAG = 'AppBookingAPIRepository';

  APIProvider _apiProvider;
  DBBookingRepository _dbAppStoreRepository;

  AppBookingAPIRepository(this._apiProvider, this._dbAppStoreRepository);

  Future<List<Task>> getTag(){
   // final api = APIProvider(_dio, baseUrl: "http://mockserver");
    // final options = buildCacheOptions(Duration(days: 10));

    // api.getTags(options: options).then((it) {
    //   print(it.length);
    // });
    return _apiProvider.getTasks();
  }

//  Observable<List<AppContent>> getTop100FreeApp(){
//    return Observable.fromFuture(_apiProvider.getTopFreeApp(TOP_100))
//        .flatMap(_convertFromEntry)
//        .flatMap((List<AppContent> list){
//      return Observable.fromFuture(_loadAndSaveTopFreeApp(list, ''));
//    });
//  }
//


  void throwIfNoSuccess(Response response) {
    if(response.statusCode < 200 || response.statusCode > 299) {
      throw new HttpException(response);
    }
  }
}