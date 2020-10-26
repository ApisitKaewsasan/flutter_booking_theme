

import 'dart:convert';

import 'package:ds_book_app/app/model/pojo/Checkin.dart';
import 'package:ds_book_app/app/model/pojo/Filter.dart';
import 'package:ds_book_app/app/model/pojo/Guests.dart';
import 'package:ds_book_app/app/model/pojo/Sort.dart';
import 'package:sqflite/sqflite.dart';

class DBBookingRepository{

  Database _database;

  DBBookingRepository(this._database);


  Future<void> Insert_Room_Guests(Guests guests) async{
    return await _database.insert("Guests_From", guests.toMap());
  }


  Future<int> CountGuests() async {
    int count = Sqflite.firstIntValue(await _database.rawQuery('SELECT COUNT(*) FROM Guests_From'));
    return count;
  }




  Future<int> deleteRoom_Guests(int id) async {


    return await _database.delete("Guests_From", where: "id = ?", whereArgs: [id],);
  }

  Future<List<Guests>> getGuests() async {
    final maps = await _database.query("Guests_From");
    if (maps.length > 0) {
      return maps.map((p) => Guests.fromMap(p)).toList();
    }
    return [];
  }

  Future<void> DeleteAllRoom() async {
    String sql = "DELETE   FROM Guests_From";
    return await _database.rawUpdate(sql);
  }


  Future<void> AdultsAdd(int id,int num) async {
    String sql = "UPDATE Guests_From SET adults_count=adults_count+$num WHERE id=$id";
    return await _database.rawUpdate(sql);
  }

  Future<void> ChildrenAdd(int id,int num) async {
    String sql = "UPDATE Guests_From SET children_count=children_count+$num WHERE id=$id";
    return await _database.rawUpdate(sql);
  }



  Future<void> Insert_Date_Check(Checkin checkin) async{
    return await _database.insert("Checkin_From", checkin.toMap());
  }


  Future<void> DeleteAllCheck() async {
    String sql = "DELETE   FROM Checkin_From";
    return await _database.rawUpdate(sql);
  }

  Future<int> CountChecks() async {
    int count = Sqflite.firstIntValue(await _database.rawQuery('SELECT COUNT(*) FROM Checkin_From'));
    return count;
  }

  Future<List<Checkin>> get_Date_Check() async{
    final maps = await _database.query("Checkin_From");
    if (maps.length > 0) {
      return maps.map((p) => Checkin.fromMap(p)).toList();
    }
    return [];
  }

  Future<void> Update_Date_Check(Checkin checkin) async{

      return await _database.update("Checkin_From", checkin.toMap());

  }


  Future<void> Insert_Room_Filter(Filter filter) async{
    return await _database.insert("Filter_From", filter.toMap());

  }

  Future<void> Update_Date_Filter(Filter filter) async{
    return await _database.update("Checkin_From", filter.toMap());
  }

  Future<void> Update_Date_Filter_By_Id(String val,int num) async{
    String sql = "UPDATE Filter_From SET $val=$num WHERE id=1";
    return await _database.rawUpdate(sql);
  }


  Future<int> CountFilter() async {
    int count = Sqflite.firstIntValue(await _database.rawQuery('SELECT COUNT(*) FROM Filter_From'));
    return count;
  }

  Future<void> DeleteFilter() async {
    String sql = "DELETE   FROM Filter_From";
    return await _database.rawUpdate(sql);
  }

  Future<List<Filter>> getFilter() async {
    final maps = await _database.query("Filter_From");
    if (maps.length > 0) {
      return maps.map((p) => Filter.fromMap(p)).toList();
    }
    return [];
  }

  Future<int> CountSort() async {
    int count = Sqflite.firstIntValue(await _database.rawQuery('SELECT COUNT(*) FROM Sort_From'));
    return count;
  }


  Future<List<Sort>> getSort() async {
    final maps = await _database.query("Sort_From");
    if (maps.length > 0) {
      return maps.map((p) => Sort.fromMap(p)).toList();
    }
    return [];
  }

  Future<void> Insert_Sort(Sort sort) async{
    return await _database.insert("Sort_From", sort.toMap());

  }

  Future<void> Update_Sort(Sort sort) async{
    return await _database.update("Sort_From", sort.toMap());
  }






}