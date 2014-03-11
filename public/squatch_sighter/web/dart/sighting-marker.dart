library SightingsMarker;

import "dart:convert";
import "package:google_maps/google_maps.dart";

class SightingMarker extends Marker {
  InfoWindow _infoWindow;
  int id;
  String name;
  
  SightingMarker(this.id, this.name, double lat, double lng) {
    position = new LatLng(lat, lng);
  }
  
  factory SightingMarker.fromMap(Map map) {
    int id = map["id"];
    String name = map["name"];
    double lat = map["latitude"];
    double lng = map["longitude"];
    return new SightingMarker(id, name, lat, lng);
  }
  
  factory SightingMarker.fromJson(String json) {
    Map map = JSON.decode(json);
    return new SightingMarker.fromMap(map);
  }
  
  void show(GMap map, InfoWindow infoWindow) {
    this.map = map;
    onClick.listen((e) {
      infoWindow
        ..content = _getText()
        ..position = position
        ..open(map);
    });
  }
  
  String _getText() {
    return [
      "Squatch Sighting:",
      "Position: (${position.lat.toStringAsFixed(2)}, ${position.lng.toStringAsFixed(2)})",
      "<button id='moreInfoBtn'>More Info</button>"
      ]
       .join("<br>"); 
  } 
}