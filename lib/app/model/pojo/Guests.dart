
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Guests{
  int id;
  int adults_count;
  int children_count;

  Guests({this.id,this.adults_count, this.children_count});

  Guests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adults_count = json['adults_count'];
    children_count = json['children_count'];
  }



  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adults_count'] = this.adults_count;
    data['children_count'] = this.children_count;
    return data;
  }



  Guests.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    adults_count = map['adults_count'];
    children_count = map['children_count'];
  }

}