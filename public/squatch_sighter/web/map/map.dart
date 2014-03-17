import "dart:convert";
import "dart:html";
import "lib/squatch-map.dart";
import "lib/sighting-marker.dart";


void main() {
  SquatchMap map = new SquatchMap(querySelector("#map-canvas"));
  
  // Grab and show all previous sightings.
  HttpRequest.request("/sighting/all")
  .then((HttpRequest request) {
    List<Map<String, String>> sightings = JSON.decode(request.responseText);
    for(Map<String, String> sighting in sightings) {
      map.showSighting(new SightingMarker.fromMap(sighting));
    }
  });
}