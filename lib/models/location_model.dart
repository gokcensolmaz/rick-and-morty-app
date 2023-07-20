import 'dart:convert';

List<LocationModel> locationModelResponseFromJson(String str) => LocationModel.fromJson(json.decode(str));
String locationModelResponseToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  Info? info;
  List<Locations>? results;

  LocationModel({this.info, this.results});

  LocationModel.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      results = <Locations>[];
      json['results'].forEach((v) {
        results!.add(new Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  int? count;
  int? pages;
  String? next;
  Null? prev;

  Info({this.count, this.pages, this.next, this.prev});

  Info.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pages = json['pages'];
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['pages'] = this.pages;
    data['next'] = this.next;
    data['prev'] = this.prev;
    return data;
  }
}

class Locations {
  int? id;
  String? name;
  String? type;
  String? dimension;
  List<String>? residents;
  String? url;
  String? created;

  Locations(
      {this.id,
        this.name,
        this.type,
        this.dimension,
        this.residents,
        this.url,
        this.created});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    dimension = json['dimension'];
    residents = json['residents'].cast<String>();
    url = json['url'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['dimension'] = this.dimension;
    data['residents'] = this.residents;
    data['url'] = this.url;
    data['created'] = this.created;
    return data;
  }
}
