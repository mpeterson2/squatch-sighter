library InfoWindowContent;

import "package:google_maps/google_maps.dart";

class IWContent {
  static String newSighting(LatLng pos) {
    return [
      "Share New Sighting:",
      "Position: (${pos.lat.toStringAsFixed(2)}, ${pos.lng.toStringAsFixed(2)})",
      "<button id='createBtn'>Share</button>"
      ]
       .join("<br>");    
  }
}