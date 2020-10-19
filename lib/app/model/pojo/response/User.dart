

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User{
  String id;
  String fullname;
  String username;
  String email;
  String phone;
  String imageurl;

  User({this.id,this.fullname, this.username,this.email,this.phone,this.imageurl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    imageurl = json['imageurl'];
  }



  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['imageurl'] = this.imageurl;
    return data;
  }



  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    fullname = map['fullname'];
    username = map['username'];
    email = map['email'];
    phone = map['phone'];
    imageurl = map['imageurl'];
  }

}