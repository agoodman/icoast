$(function() {
	$("#prev-pre, #pre-thumb0").click(function() { iCoast.showPre(gPrePosition-1); });
	$("#next-pre, #pre-thumb2").click(function() { iCoast.showPre(gPrePosition+1); });
	$("#prev-post, #post-thumb0").click(function() { iCoast.showPost(gPostPosition-1) });
	$("#next-post, #post-thumb2").click(function() { iCoast.showPost(gPostPosition+1) });
	$("#find-pre").click(function() { iCoast.findNearestPre(gPostPosition+1) });
	$("#find-post").click(function() { iCoast.findNearestPost(gPrePosition+1) });
	$("#show-map").click(function() { iCoast.showMap(); });
	$("#shuffle-post").click(function() { iCoast.findRandomPost(); });
	
	$("#pre, #pre-thumb0, #pre-thumb1, #pre-thumb2, #post, #post-thumb0, #post-thumb1, #post-thumb2").load(function() { $(this).removeClass('loading'); });
	$("#pre").loupe({loupe: 'pre-loupe'});
	$("#post").loupe({loupe: 'post-loupe'});
	$("nav .map").click(function() { 
		iCoast.showMap();
	});
	$(document).keyup(function(e) {
		if( e.keyCode==27 ) {
			iCoast.hideMap();
			e.preventDefault();
		}
	});
	
	$("section.task button.next").click(function() { iCoast.nextTask(); });
	$("section.task button.prev").click(function() { iCoast.prevTask(); });
	$("section.task button.done").click(function() { iCoast.resetWorkflow(); });

	$("section.task button.next, section.task button.prev, section.task button.done").click(function () {
		var el = $(this);
		$("html,body").animate({
			scrollTop:$(el.attr("href")).offset().top - 100
		}, 1000);
	});
});

(function(base,$) {

	var markers = [];
	var map;
	var mapInitialized = false;

	base.showPre = function(imageId) {
		base.loadingPre();
		$.getScript("/images/pre/"+imageId+".js");
	};

	base.showPost = function(imageId) {
		base.loadingPost();
		$.getScript("/images/post/"+imageId+".js");
	};

	base.findNearestPre = function(imageId) {
		base.loadingPre();
		$.getScript("/images/nearest_pre/"+imageId+".js");	
	};

	base.findNearestPost = function(imageId) {
		base.loadingPost();
		$.getScript("/images/nearest_post/"+imageId+".js");
	};

	base.findRandomPost = function() {
		base.loadingPost();
		$.getScript("/images/post/random.js");
	}

	base.loadingPre = function() {
		$('#pre, #pre-thumb0, #pre-thumb1, #pre-thumb2').addClass('loading');
	};

	base.loadingPost = function() {
		$('#post, #post-thumb0, #post-thumb1, #post-thumb2').addClass('loading');	
	};

	base.initializeMap = function() {
		if( mapInitialized ) return;

		var mapOptions = {
			center: new google.maps.LatLng(38.84435486162807, -74.03361157242779),
			zoom: 8,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		};
		map = new google.maps.Map(document.getElementById("map"), mapOptions);

		mapInitialized = true;
	};

	base.loadMarkers = function(map,pre,page,perPage) {
		$.getJSON('/images/'+(pre?'pre':'post')+'.json?page='+page+'&per_page='+perPage+'&only=position,latitude,longitude,position', function(data) {
			if( data.length!=0 ) {
				base.loadMarkers(map,pre,page+1,perPage);
			}
			$.each(data, function(key,val) {
				var annotated = val.annotated;
				var isCurrentPost = !pre && val.position==gPostPosition;
				var icon = '/assets/' + (pre?'blue':(isCurrentPost?'yellow':(annotated?'green':'red'))) + '-dot.png';
				var marker = new google.maps.Marker({
					position: new google.maps.LatLng(val.latitude,val.longitude), 
					map: map,
					icon: icon
				});
				if( !pre ) {
					google.maps.event.addListener(marker, 'click', function() {
						// not exactly sure why this delay is needed, but it seems to work
						setTimeout(base.hideMap, 100);
						base.showPost(val.position);
						base.findNearestPre(val.position);
					});
				}
				markers.push(marker);
			});
			console.log("loaded "+data.length+" "+(pre?'pre':'post')+" images");
		});
	};

	base.showMap = function() {
		if( !mapInitialized ) {
			base.initializeMap();
		}
		$("section.map").addClass("open");
		map.setCenter(new google.maps.LatLng(gPostLatitude, gPostLongitude));
		map.setZoom(12);
		setTimeout(function() {
			if( markers.length==0 ) {
				// load placemarks for images
				// loadMarkers(map, true, 1, 1000);
				base.loadMarkers(map, false, 1, 1000);
			}
		}, 500);
	};

	base.hideMap = function() {
		$('section.map.open').removeClass("open");
		setTimeout(function() {
			for (var k=0;k<markers.length;k++) {
				markers[k].setMap(null);
			};
			markers.length = 0;
		}, 500);
	};

	base.resetWorkflow = function() {
		$('section.task')
			.removeClass('active')
			.first()
			.addClass('active');
		// $('section.task').find('input, textarea, button')
		// 	.prop("disabled", true);
		// $('section.task.active').find('input, textarea, button')
		// 	.prop("disabled", false);
	};

	base.nextTask = function() {
		$('section.task.active + section.task')
			.addClass('active')
			.prev()
			.removeClass('active');
		// $('section.task').find('input, textarea, button')
		// 	.prop("disabled", true);
		// $('section.task.active').find('input, textarea, button')
		// 	.prop("disabled", false);
	};

	base.prevTask = function() {
		$('section.task.active')
			.prev()
			.addClass('active')
			.next()
			.removeClass('active');
	};
	
})(window.iCoast = window.iCoast || {}, $);
