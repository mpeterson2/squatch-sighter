import "dart:html";

Map<String, String> getArgs() {
  Map<String, String> map = new Map();
  try {
    String queryString = window.location.search.replaceFirst("?", "");
    for(String pair in queryString.split("&")) {
      List<String> kv = pair.split("=");
      map[kv[0]] = kv[1];
    }
  } catch(e) {}
  
  return map;
}