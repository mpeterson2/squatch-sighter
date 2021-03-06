library InfoWindowContent;

import "dart:html";
import "package:google_maps/google_maps.dart";
import "sighting-marker.dart";

class IWContent {
  
  static FormElement get form {
    return querySelector("#new-sighting");
  }
  
  static String get title {
    if(isNew) {
      TextInputElement t = querySelector("#title");
      return t.value;
    }
    
    return querySelector("#title").text;
  }
  
  static String get description {
    if(isNew) {
      TextAreaElement t = querySelector("#description");
      return t.value;
    }
    
    return querySelector("#description").text;
  }
  
  static String get name {
    if(isNew) {
      TextInputElement t = querySelector("#name");
      return t.value;
    }
    
    return querySelector("#name").text;
  }
  
  static String get contactInfo {
    if(isNew) {
      TextInputElement t = querySelector("#contactInfo");
      return t.value;
    }
    
    return querySelector("#contactInfo").text;
  }
  
  static String get latitude {
    if(isNew) {
      TextInputElement t = querySelector("#lat");
      return t.value;
    }
    
    return querySelector("#lat").text;
  }
  
  static String get longitude {
    if(isNew) {
      TextInputElement t = querySelector("#lng");
      return t.value;
    }
  
    return querySelector("#lng").text;
  }
  
  static List<File> get media {
    if(isNew) {
      InputElement t = querySelector("#media");
      return t.files;
    }
    
    return null;
  }
  
  static DateTime get date {
    if(isNew) {
      DateInputElement t = querySelector("#date");
      return t.valueAsDate;
    }
    
    return DateTime.parse(querySelector("#date").text);
  }
  
  static DateTime get recordDate {
    if(isNew) {
      return new DateTime.now();
    }
    
    return DateTime.parse(querySelector("#recordDate").text);
  }
  
  static ButtonElement get shareBtn {
    if(isNew)
      return querySelector("#shareBtn");
    return null;
  }
  
  static ButtonElement get moreInfoBtn {
    if(isNew)
      return null;
    return querySelector("#moreInfoBtn");
  }
  
  static bool get isNew {
    return querySelector("#shareBtn") != null;
  }  
  
  static String newSighting(LatLng pos) {
    return """
<form id="new-sighting">
  <table>
    <tr>
      <td><lable style="font-weight: bold;">Title: </lable></td>
      <td><input id="title" name="title" type="text" placeholder="Title" /></td>
    </tr>
    
    <tr>
      <td><lable style="font-weight: bold;">Description: </lable></td>
      <td><textarea id="description" name="description" type="text" placeholder="Description"></textarea></td>
    </tr>
    
    <tr>
      <td><lable style="font-weight: bold;">Name/Alias: </lable></td>
      <td><input id="name" name="name" type="text" placeholder="Name/Alias" /></td>
    </tr>
    
    <tr>
      <td><lable style="font-weight: bold;">Contact Info: </lable></td>
      <td><input id="contactInfo" name="contact_info" type="text" placeholder="Contact Info" /></td>
    </tr>

    <tr>
      <td><lable style="font-weight: bold;">Date Sighted: </lable></td>
      <td><input id="date" name="date" type="date" /></td>
    </tr>
    
    <tr>
      <td><lable style="font-weight: bold;">Latitude: </lable></td>
      <td><input id="lat" name="lat" type="text" value="${pos.lat}" placeholder="latitude" /></td>
    </tr>

    <tr>
      <td><lable style="font-weight: bold;">Longitude: </lable></td>
      <td><input id="lng" name="lng" type="text" value="${pos.lng}" placeholder="longitude" /></td>
    </tr>

    <tr>
      <td><lable style="font-weight: bold;">Media: </lable></td>
      <td><input id="media" type="file" accept="image/*" multiple/></td>
    </tr>
    
    <tr>
      <td></td>
      <td><input id="shareBtn" type="submit" value="Share" /></td>
    </tr>
  </table>
</form>
""";
  }
  
  static String marker(SightingMarker sm) {
    DateTime date = sm.date.toLocal();
    DateTime recordDate = sm.recordDate.toLocal();
    
    return """
<h2 style="text-align: center">${sm.title}</h2>
<table>  
  <tr>
    <td><lable style="font-weight: bold;">Name/Alias: </lable></td>
    <td id="name">${sm.name}</td>
  </tr>
  
  <tr>
    <td><lable style="font-weight: bold;">Contact Info: </lable></td>
    <td id="contactInfo">${sm.contactInfo}</td>
  </tr>

  <tr>
    <td><lable style="font-weight: bold;">Date Sighted: </lable></td>
    <td>${date.month}/${date.day}/${date.year}</td>
  </tr>
  
  <tr>
    <td><lable style="font-weight: bold;">Date Recorded: </lable></td>
    <td>${recordDate.month}/${recordDate.day}/${recordDate.year}</td>
  </tr>

  <tr>
    <td><lable style="font-weight: bold;">Latitude: </lable></td>
  <td id="lat">${sm.position.lat}</td>
  </tr>
  
  <tr>
    <td><lable style="font-weight: bold;">Longitude: </lable></td>
  <td id="lng">${sm.position.lng}</td>
  </tr>
</table>
<p>
${sm.shortDesc.replaceAll("\n", "</p><p>")}
</p>
<div style="text-align: center;">
  <button id="moreInfoBtn">More Info</button>
</div>
""";
  }
}