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
    ..scaleControl = true
    ..mapTypeId = MapTypeId.HYBRID;
    
    map = new GMap(mapElement, mOptions);
    _infoWindow = new InfoWindow(new InfoWindowOptions());
    
    gotoLocation();
    _setupEvents();
  }
  
  void _setupEvents() {
    map.onClick.listen((MouseEvent e) {
      _infoWindow.close();
      _infoWindow
          ..content = IWContent.newSighting(e.latLng)
          ..position = e.latLng
          ..open(map);
    });
    
    _infoWindow.onDomready.listen((MouseEvent e) {      
      ButtonElement shareBtn = querySelector("#shareBtn");
      if(shareBtn != null) {
        shareBtn.onClick.listen((Event e) {
          e.preventDefault();
          e.stopPropagation();
          _shareSighting();
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
      map..center = NORTH_AMERICA
         ..zoom = 4;
    });
  }
  
  void _shareSighting() {
    Map data = new Map();
    data["title"] = IWContent.title;
    data["description"] = IWContent.description;
    data["name"] = IWContent.name;
    data["contact_info"] = IWContent.contactInfo;
    data["date"] = IWContent.date.toUtc().toString();
    data["lat"] = IWContent.latitude;
    data["lng"] = IWContent.longitude;

    HttpRequest.request("/sighting/new", method: "post", sendData: JSON.encode(data))
    .then((HttpRequest request) {
      showSightingId(int.parse(request.responseText));
    });
    
    _infoWindow.close();
  }
  
  void showSightingId(int id) {
    HttpRequest.request("/sighting/$id")
    .then((HttpRequest request) {
      showSighting(new SightingMarker.fromJson(request.responseText));
    });
  }
  
  void showSighting(SightingMarker marker) {
    marker.show(map, _infoWindow);
  }
}