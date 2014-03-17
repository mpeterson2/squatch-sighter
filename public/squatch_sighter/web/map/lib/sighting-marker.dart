library SightingsMarker;

import "dart:convert";
import "package:google_maps/google_maps.dart";
import "info-window-content.dart";
import "squatch-map.dart";

class SightingMarker extends Marker {
  InfoWindow _infoWindow;
  int id;
  String title;
  String description;
  String name;
  String contactInfo;
  DateTime date;
  DateTime recordDate;
  
  SightingMarker(this.id, this.title, this.description, this.name, this.contactInfo, this.date, this.recordDate, double lat, double lng) {
    position = new LatLng(lat, lng);
  }
  
  factory SightingMarker.fromMap(Map map) {
    int id = map["id"];
    String title = map["title"];
    String description = map["description"];
    String name = map["name"];
    String contactInfo = map["contact_info"];
    double lat = map["latitude"];
    double lng = map["longitude"];
    DateTime date = DateTime.parse(map["date"]);
    DateTime recordDate = DateTime.parse(map["record_date"]);
    return new SightingMarker(id, title, description, name, contactInfo, date, recordDate, lat, lng);
  }
  
  factory SightingMarker.fromJson(String json) {
    Map map = JSON.decode(json);
    return new SightingMarker.fromMap(map);
  }
  
  String get shortDesc {
    if(description.length > 500)
      return description.substring(0, 500) + "...";
    return description;
  }
  
  void show(SquatchMap sMap, InfoWindow infoWindow) {
    map = sMap.map;
    onClick.listen((e) {
      sMap.clickedMarker = this;
      infoWindow
        ..content = IWContent.marker(this)
        ..open(map, this);
    });
  }
}