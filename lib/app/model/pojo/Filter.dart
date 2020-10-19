import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Filter{
  int id;
  int single;
  int double;
  int deluxe;
  int superdeluxe;
  int swimming;
  int wifi;
  int parking;
  int cabletv;
  int floorone;
  int floortwo;
  int floorthee;
  int floorfour;
  int starone;
  int startwo;
  int starthee;
  int starfour;

  Filter({this.id,this.single,this.double,this.deluxe,this.superdeluxe,this.swimming,this.wifi,this.parking,this.cabletv,this.floorone,this.floortwo,this.floorthee,this.floorfour,this.starone
  ,this.startwo,this.starthee,this.starfour});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['single'] = this.single;
    data['double'] = this.double;
    data['deluxe'] = this.deluxe;
    data['superdeluxe'] = this.superdeluxe;
    data['swimming'] = this.swimming;
    data['wifi'] = this.wifi;
    data['parking'] = this.parking;
    data['cabletv'] = this.cabletv;
    data['floorone'] = this.floorone;
    data['floortwo'] = this.floortwo;
    data['floorthee'] = this.floorthee;
    data['floorfour'] = this.floorfour;
    data['starone'] = this.starone;
    data['startwo'] = this.startwo;
    data['starthee'] = this.starthee;
    data['starfour'] = this.starfour;

    return data;
  }




  Filter.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    single = map['single'];
    double = map['double'];
    deluxe = map['deluxe'];
    superdeluxe = map['superdeluxe'];
    swimming = map['swimming'];
    wifi = map['wifi'];
    parking = map['parking'];
    cabletv = map['cabletv'];
    floorone = map['floorone'];
    floortwo = map['floortwo'];
    floorthee = map['floorthee'];
    floorfour = map['floorfour'];
    starone = map['starone'];
    startwo = map['startwo'];
    starthee = map['starthee'];
    starfour = map['starfour'];
  }


}