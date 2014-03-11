var NORTH_AMERICA_POS = new google.maps.LatLng(40, -95);
var BLUE_MAP_ICON = "http://google.com/mapfiles/ms/micons/blue-dot.png";
var map;
var sightingWindow;


$(document).ready(function() {
	sightingWindow = new google.maps.InfoWindow({
		maxWidth: 10000,
		maxHeight: 10000
	});

	createMap();
	getLocation();
	setupEvents();

	showSighting(NORTH_AMERICA_POS);
})

function createMap() {
	var options = {
		mapTypeId: google.maps.MapTypeId.HYBRID
	}
	map = new google.maps.Map($("#map")[0], options);
}

function getLocation() {
	// TODO CHANGE
	if(!navigator.geolocation) {
		window.navigator.geolocation.getCurrentPosition(function(pos) {
			map.setZoom(10);
			map.setCenter(new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude));
		});
	}
	else {
		map.setZoom(4);
		map.setCenter(NORTH_AMERICA_POS);
	}
}

function setupEvents() {
	google.maps.event.addListener(map, "click", function(e) {
		sightingWindow.setContent(getNewSightingWindowText(e.latLng));
		sightingWindow.setPosition(e.latLng);
		sightingWindow.open(map);
	});
}

function getNewSightingWindowText(pos) {

	var button = $("<button/>", {
		text: "Share",
		click: function() {addNewSighting(pos)}
	});

	return [
		"Share New Sighting",
		"Position: " + pos.d.toFixed(2) + ", " + pos.e.toFixed(2),
		"<button onclick='addNewSighting("+pos.d+","+pos.e+")'>Share</button>"
		].join("<br>");
}

function getSightingsWindowText(pos) {
	return [
		"Sighting",
		"Position: " + pos.d.toFixed(2) + ", " + pos.e.toFixed(2),
		].join("<br>");
}

function showSighting(position) {
	var marker = new google.maps.Marker({
		position: position,
		map: map,
		icon: BLUE_MAP_ICON,
		title: "Sighting"
	});

	google.maps.event.addListener(marker, "click", function(e) {
		sightingWindow.setContent(getSightingsWindowText(marker.position))
		sightingWindow.setPosition(marker.position)
		sightingWindow.open(map)
	});
}

function addNewSighting(lat, lgn) {
	data = {
		lat: lat,
		lgn: lgn
	}

	$.post("/sighting/new", data, function(data) {
		console.log(data)
	})
}