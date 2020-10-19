

import 'package:dio/dio.dart';
import 'package:ds_book_app/app/model/pojo/response/Task.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/http/HttpException.dart';
import 'package:ds_book_app/utility/log/DioLogger.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'APIProvider.g.dart';

abstract class APIProvider{
  factory APIProvider(Dio dio, {String baseUrl}) = _APIProvider;

  @GET("/tasks")
  Future<List<Task>> getTasks();

}

// @JsonSerializable()
// class Task {
//   String id;
//   String name;
//   String avatar;
//   String createdAt;
//
//   Task({this.id, this.name, this.avatar, this.createdAt});
//
//
//   factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
//   Map<String, dynamic> toJson() => _$TaskToJson(this);
// }
