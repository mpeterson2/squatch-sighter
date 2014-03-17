library SquatchMap;

import "dart:html" hide MouseEvent;
import "package:google_maps/google_maps.dart";
import 'info-window-content.dart';
import "sighting-marker.dart";

class SquatchMap {
  final LatLng NORTH_AMERICA = new LatLng(40, -95);
  GMap map;
  InfoWindow _infoWindow;
  SightingMarker clickedMarker;
  
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
      ButtonElement shareBtn = IWContent.shareBtn;
      if(shareBtn != null) {
        shareBtn.onClick.listen((Event e) {
          e.preventDefault();
          e.stopPropagation();
          _shareSighting();
        });
      }
      
      ButtonElement moreInfoBtn = IWContent.moreInfoBtn;
      if(moreInfoBtn != null) {
        moreInfoBtn.onClick.listen((e) {
          _moreInfo();
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
    
    FormData form = new FormData(IWContent.form);
    for(File f in IWContent.media) {
      form.appendBlob("media-${f.name}", f, f.name);
    }

    HttpRequest.request("/sighting/new", method: "post", sendData: form)
    .then((HttpRequest request) {
      showSightingId(int.parse(request.responseText));
    });
    
    _infoWindow.close();
  }
  
  void _moreInfo() {
    int id = clickedMarker.id;
    window.location.assign("/sighting/info/$id");
  }
  
  void showSightingId(int id) {
    HttpRequest.request("/sighting/$id")
    .then((HttpRequest request) {
      showSighting(new SightingMarker.fromJson(request.responseText));
    });
  }
  
  void showSighting(SightingMarker marker) {
    marker.show(this, _infoWindow);
  }
}