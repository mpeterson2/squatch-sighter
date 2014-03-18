import "dart:convert";
import "dart:html";
import "../utilities.dart";
import "lib/squatch-map.dart";
import "lib/sighting-marker.dart";


void main() {
  Map<String, String> args = getArgs();
  SquatchMap map;
  try {
    double lat = double.parse(args["lat"]);
    double lng = double.parse(args["lng"]);
    double zoom = double.parse(args["zoom"]);
    map = new SquatchMap(querySelector("#map-canvas"), lat, lng, zoom);
  } catch(e) {
    map = new SquatchMap(querySelector("#map-canvas"));
  }  
  
  // Grab and show all previous sightings.
  HttpRequest.request("/sighting/all")
  .then((HttpRequest request) {
    List<Map<String, String>> sightings = JSON.decode(request.responseText);
    for(Map<String, String> sighting in sightings) {
      map.showSighting(new SightingMarker.fromMap(sighting));
    }
  });
}