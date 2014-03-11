library SquatchMap;

import "dart:convert";
import "dart:html" hide MouseEvent;
import "package:google_maps/google_maps.dart";
import 'info-window-content.dart';
import 'sighting-marker.dart';

class SquatchMap {
  final LatLng NORTH_AMERICA = new LatLng(40, -95);
  GMap map;
  InfoWindow _infoWindow;
  
  SquatchMap(Node mapElement) {
    MapOptions mOptions = new MapOptions()
    ..mapTypeId = MapTypeId.HYBRID;
    
    map = new GMap(mapElement, mOptions);
    _infoWindow = new InfoWindow();
    
    gotoLocation();
    _setupEvents();
  }
  
  void _setupEvents() {
    map.onClick.listen((MouseEvent e) {
      _infoWindow
          ..content = IWContent.newSighting(e.latLng)
          ..position = e.latLng
          ..open(map);
    });
    
    _infoWindow.onDomready.listen((MouseEvent e) {
      ButtonElement createBtn = querySelector("#createBtn");
      if(createBtn != null) {
        createBtn.onClick.listen((_) {
          shareSighting(_infoWindow.position);
        });
      }
    });
  }
  
  void gotoLocation() {
    window.navigator.geolocation.getCurrentPosition()
    .then((Geoposition pos){
      map..center = new LatLng(pos.coords.latitude, pos.coords.longitude)
         ..zoom = 10;
    })
    .catchError((e) {
      print("Could not get location");
      map..center = NORTH_AMERICA
         ..zoom = 4;
    });
  }
  
  void shareSighting(LatLng pos) {
    Map data = new Map();
    data["lat"] = pos.lat;
    data["lng"] = pos.lng;

    HttpRequest.request("/sighting/new", method: "post", sendData: JSON.encode(data))
    .then((HttpRequest request) {
      showSightingId(int.parse(request.responseText));
    });
  }
  
  void showSightingId(int id) {
    HttpRequest.request("/sighting/$id")
    .then((HttpRequest request) {
      print(request.responseText);
      showSighting(new SightingMarker.fromJson(request.responseText));
    });
  }
  
  void showSighting(SightingMarker marker) {
    marker.show(map, _infoWindow);
  }
}