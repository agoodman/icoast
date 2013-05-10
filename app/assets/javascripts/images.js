var markers = [];

$(function() {
	$("#prev-pre, #pre-thumb0").click(function() { showPre(gPrePosition-1); });
	$("#next-pre, #pre-thumb2").click(function() { showPre(gPrePosition+1); });
	$("#prev-post, #post-thumb0").click(function() { showPost(gPostPosition-1) });
	$("#next-post, #post-thumb2").click(function() { showPost(gPostPosition+1) });
	$("#find-pre").click(function() { findNearestPre(gPostPosition+1) });
	$("#find-post").click(function() { findNearestPost(gPrePosition+1) });
	$("#show-map").click(function() { showMap(); });
	
	$("#pre, #pre-thumb0, #pre-thumb1, #pre-thumb2, #post, #post-thumb0, #post-thumb1, #post-thumb2").load(function() { $(this).removeClass('loading'); });
	initializeMap();
});

function showPre(imageId) {
	loadingPre();
	$.getScript("/images/pre/"+imageId+".js");
}

function showPost(imageId) {
	loadingPost();
	$.getScript("/images/post/"+imageId+".js");
}

function findNearestPre(imageId) {
	loadingPre();
	$.getScript("/images/nearest_pre/"+imageId+".js");	
}

function findNearestPost(imageId) {
	loadingPost();
	$.getScript("/images/nearest_post/"+imageId+".js");
}

function loadingPre() {
	$('#pre, #pre-thumb0, #pre-thumb1, #pre-thumb2').addClass('loading');
}

function loadingPost() {
	$('#post, #post-thumb0, #post-thumb1, #post-thumb2').addClass('loading');	
}

function initializeMap() {
	var mapOptions = {
		center: new google.maps.LatLng(38.84435486162807, -74.03361157242779),
		zoom: 8,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	var map = new google.maps.Map(document.getElementById("map"), mapOptions);

	// load placemarks for images
	loadMarkers(map, true, 1, 1000);
	loadMarkers(map, false, 1, 1000);
}

function loadMarkers(map,pre,page,perPage) {
	$.getJSON('/images/'+(pre?'pre':'post')+'.json?page='+page+'&per_page='+perPage+'&only=latitude,longitude,position', function(data) {
		if( data.length!=0 ) {
			loadMarkers(map,pre,page+1,perPage);
		}
		$.each(data, function(key,val) {
			var marker = new google.maps.Marker({
				position: new google.maps.LatLng(val.latitude,val.longitude), 
				map: map,
				icon: (pre?'/assets/red-dot.png':'/assets/blue-dot.png')
			});
			if( pre ) {
				google.maps.event.addListener(marker, 'click', function() {
					hideMap();
					showPre(val.position);
					findNearestPost(val.position);
				});
			}else{
				google.maps.event.addListener(marker, 'click', function() {
					hideMap();
					showPost(val.position);
					findNearestPre(val.position);
				});
			}
			markers.push(marker);
		});
		console.log("loaded "+data.length+" "+(pre?'pre':'post')+" images");
	});
}

function showMap() {
	$('#map').show();
}

function hideMap() {
	$('#map').hide();
}

