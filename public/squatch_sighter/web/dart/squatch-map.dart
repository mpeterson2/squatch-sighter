library SquatchMap;

import "dart:html" hide MouseEvent;
import "package:google_maps/google_maps.dart";

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
    
  }
}