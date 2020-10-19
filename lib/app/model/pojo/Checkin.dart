import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Checkin{
  int id;
  String checkin;
  String checkout;

  Checkin({this.id,this.checkin, this.checkout});

  Checkin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkin = json['checkin'];
    checkout = json['checkout'];
  }



  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    return data;
  }



  Checkin.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    checkin = map['checkin'];
    checkout = map['checkout'];
  }

}