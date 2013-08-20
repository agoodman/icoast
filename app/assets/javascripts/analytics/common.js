(function(base,$) {
	
	var boundsLatNE, boundsLngNE, boundsLatSW, boundsLngSW;
	var map;
	var markers;
	
	base.setBoundsByCenter = function(lat,lng,radius) {
		base.boundsLatNE = lat+radius;
		base.boundsLngNE = lng+radius;
		base.boundsLatSW = lat-radius;
		base.boundsLngSW = lng-radius;
	};
	
	base.setBoundsByCorners = function(latNE,lngNE,latSW,lngSW) {
		base.boundsLatNE = latNE;
		base.boundsLngNE = lngNE;
		base.boundsLatSW = latSW;
		base.boundsLngSW = lngSW;
	};
	
	base.mapCenterChanged = function() {
		var bounds = base.map.getBounds();
		var latNE = bounds.getNorthEast().lat(),
			lngNE = bounds.getNorthEast().lng(),
			latSW = bounds.getSouthWest().lat(),
			lngSW = bounds.getSouthWest().lng();
		base.setBoundsByCorners(latNE, lngNE, latSW, lngSW);
	};
	
	base.init = function() {
		base.initState();
		base.initEvents();
		base.initMap();
		google.maps.event.addListener(base.map, 'center_changed', base.mapCenterChanged);
		console.log("iCoast Analytics init OK");
	};
	
	base.initEvents = function() {
		$('#refresh-images').click(base.showImages);
		$('#show-pre').click(function() { 
			base.showPre = true;
			base.showPost = base.showAll = false;
			$(this).addClass('active');
			$('#show-post, #show-all').removeClass('active');
		});
		$('#show-post').click(function() {
			base.showPost = true;
			base.showPre = base.showAll = false;
			$(this).addClass('active');
			$('#show-pre, #show-all').removeClass('active');
		});
		$('#show-all').click(function() {
			base.showAll = true;
			base.showPre = base.showPost = false;
			$(this).addClass('active');
			$('#show-pre, #show-post').removeClass('active');
		});
		$('#enabled_yes').change(function() {
			var checked = $(this).prop("checked");
			base.showEnabled = checked;
		});
		$('#enabled_no').change(function() {
			var checked = $(this).prop("checked");
			base.showEnabled = !checked;
		});
		$('#detail .close').click(function() {
			$('#detail').hide();
		});
	};
	
	base.initMap = function() {
		var mapOptions = {
			center: new google.maps.LatLng(38.84435486162807, -74.03361157242779),
			zoom: 8,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		};
		base.map = new google.maps.Map(document.getElementById("map"), mapOptions);
	};
	
	base.initState = function() {
		$('#show-all').addClass('active');
		$('#show-pre, #show-post').removeClass('active');
		base.showAll = true;
		base.showPre = base.showPost = false;
		
		$('#enabled_yes').prop("checked", true);
		$('#enabled_no').prop("checked", false);
		base.showEnabled = true;
	};
	
	base.boundsLatNE = boundsLatNE;
	base.boundsLngNE = boundsLngNE;
	base.boundsLatSW = boundsLatSW;
	base.boundsLngSW = boundsLngSW;	
	base.map = map;
	base.markers = markers;
		
})(window.iCoast = window.iCoast || {},$);
