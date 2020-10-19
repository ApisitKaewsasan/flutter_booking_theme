import 'package:ds_book_app/utility/db/DatabaseHelper.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabaseMigrationListener implements DatabaseMigrationListener {
  static const int VERSION_1_0_0 = 1;

  @override
  void onCreate(Database db, int version) async {
    Log.info('onCreate version : $version');
    await _createDatabase(db, version);
  }

  @override
  void onUpgrade(Database db, int oldVersion, int newVersion) {
    Log.info('oldVersion : $oldVersion');
    Log.info('newVersion : $newVersion');
  }

  Future<void> _createDatabase(Database db, int version) async {
    if (VERSION_1_0_0 == version) {
      await db.execute("CREATE TABLE Guests_From (id INTEGER PRIMARY KEY AUTOINCREMENT,adults_count int,children_count int)");
      await db.execute("CREATE TABLE Checkin_From (id INTEGER,checkin text,checkout text)");
      await db.execute("CREATE TABLE Sort_From (id INTEGER,sort int)");
      await db.execute("CREATE TABLE Filter_From (id INTEGER,single int,double int,deluxe int,superdeluxe int,swimming int,wifi int"
          ",parking int,cabletv int,floorone int,floortwo int,floorthee int,floorfour int,starone int,startwo int"
          ",starthee int,starfour int)");
    }
  }
}

