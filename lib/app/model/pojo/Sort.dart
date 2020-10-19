
class Sort{
  int id;
  int sort;

  Sort({this.id, this.sort});

  Sort.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sort = json['sort'];
  }



  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sort'] = this.sort;
    return data;
  }



  Sort.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    sort = map['sort'];
  }
}