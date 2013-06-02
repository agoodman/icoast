// admin/images

var markers = [];
var markerHash = {};
var matchHash = {};
var mapInitialized = false;

$(function() {
	initializeMap();
});

function loadMarkers(map,pre,callback) {
	$.getJSON('/admin/images/'+(pre?'pre':'post')+'.json?only=id,latitude,longitude,position', function(data) {
		var image = {
			url: (pre?'/assets/blue-dot.png':'/assets/red-dot.png'),
			size: new google.maps.Size(16,16),
			origin: new google.maps.Point(0,0),
			anchor: new google.maps.Point(8,8)
		};
		$.each(data, function(key,val) {
			var marker = new google.maps.Marker({
				position: new google.maps.LatLng(val.latitude,val.longitude), 
				map: map,
				opacity: 0.1,
				icon: image
			});
			markers.push(marker);
			markerHash[val.id] = marker;
		});
		console.log("loaded "+data.length+" "+(pre?'pre':'post')+" images");
		callback();
	});
}

function loadMatches(map,callback) {
	$.getJSON('/matches.json', function(data) {
		$.each(data, function(key,val) {
			var tPreLatLng = new google.maps.LatLng(val.pre_image.latitude,val.pre_image.longitude), 
				tPostLatLng = new google.maps.LatLng(val.post_image.latitude,val.post_image.longitude);
			// find post marker
			var tPostMarker = null;
			// for(var k;k<markers.length;k++) {
			// 	if( markers[k].position==tPostLatLng ) {
			// 		tPostMarker = markers[k];
			// 		break;
			// 	}
			// }
			tPostMarker = markerHash[val.post_image.id];
			var tPreMarker = null;
			tPreMarker = markerHash[val.pre_image.id];
			var tLine = new google.maps.Polyline({
				path: [ tPostMarker.position, tPreMarker.position ],
				strokeColor: "#ffff00",
				strokeOpacity: 1.0,
				strokeWeight: 2,
				map: map
			});
		});
		console.log("loaded "+data.length+" matches");
		callback();
	});
}

function initializeMap() {
	var mapOptions = {
		center: new google.maps.LatLng(38.84435486162807, -74.03361157242779),
		zoom: 8,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	var map = new google.maps.Map(document.getElementById("map"), mapOptions);

	$("#loading").show();
	
	// load placemarks for images
	loadMarkers(map, true, function() {
		loadMarkers(map, false, function() {
			loadMatches(map, function() {
				$("#loading").hide();
			});
		});
	});
	
	mapInitialized = true;
}
