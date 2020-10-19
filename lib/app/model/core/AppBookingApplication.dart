import 'package:dio/dio.dart';
import 'package:ds_book_app/app/model/api/APIProvider.dart';
import 'package:ds_book_app/app/model/api/AppBookingAPIRepository.dart';
import 'package:ds_book_app/app/model/db/AppDatabaseMigrationListener.dart';
import 'package:ds_book_app/app/model/db/DBBookingRepository.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/db/DatabaseHelper.dart';
import 'package:ds_book_app/utility/framework/Application.dart';
import 'package:ds_book_app/utility/log/DioLogger.dart';
import 'package:ds_book_app/utility/log/Log.dart';

import 'package:logging/logging.dart';

class AppBookingApplication implements Application {

  Dio _dio;
  DatabaseHelper _db;
  DBBookingRepository dbAppStoreRepository;
  AppBookingAPIRepository appStoreAPIRepository;

  @override
  Future<void> onCreate() async {
    _initLog();
    await _initDB();
    _initDioLog();
    _initDBRepository();
    _initAPIRepository();
  }

  @override
  Future<void> onTerminate() async {
    await _db.close();
  }

  Future<void> _initDB() async {
    AppDatabaseMigrationListener migrationListener = AppDatabaseMigrationListener();
    DatabaseConfig databaseConfig = DatabaseConfig(Env.value.dbVersion, Env.value.dbName, migrationListener);
    _db = DatabaseHelper(databaseConfig);
    Log.info('DB name : ' + Env.value.dbName);
    await _db.open();
  }

  void _initDBRepository(){
    dbAppStoreRepository = DBBookingRepository(_db.database);
  }


  void _initAPIRepository(){
    APIProvider apiProvider = APIProvider(_dio,baseUrl:Env.value.baseUrl);
    appStoreAPIRepository = AppBookingAPIRepository(apiProvider, dbAppStoreRepository);
  }

  void _initLog(){
    Log.init();
    switch(Env.value.environmentType){
      case EnvType.DEVELOPMENT:
      case EnvType.STAGING:{
        Log.setLevel(Level.ALL);
        break;
      }
      case EnvType.PRODUCTION:{
        Log.setLevel(Level.INFO);
        break;
      }
    }
  }

  void _initDioLog(){
    _dio = Dio();
    if(EnvType.DEVELOPMENT == Env.value.environmentType || EnvType.STAGING == Env.value.environmentType){
      _dio.interceptors.add(InterceptorsWrapper(
          onRequest:(RequestOptions options) async{
            DioLogger.onSend(AppBookingAPIRepository.TAG, options);
            return options;
          },
          onResponse: (Response response){
            DioLogger.onSuccess(AppBookingAPIRepository.TAG, response);
            return response;
          },
          onError: (DioError error){
            DioLogger.onError(AppBookingAPIRepository.TAG, error);
            return error;
          }
      ));
    }
  }

}
