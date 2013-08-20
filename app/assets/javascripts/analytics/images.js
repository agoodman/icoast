(function(base,$) {
	
	var showPre, showPost, showAll;
	var showEnabled;

	base.showImages = function() {
		var options = {
			where: {
				images: {
					latitude: {
						gt: base.boundsLatSW,
						lt: base.boundsLatNE
					},
					longitude: {
						gt: base.boundsLngSW,
						lt: base.boundsLngNE
					}
				}
			},
			only: 'latitude,longitude,id,pre'
		};
		if( base.showPre && !base.showPost && !base.showAll ) {
			options['where']['images']['pre'] = true;
		}else if( !base.showPre && base.showPost && !base.showAll ) {
			options['where']['images']['pre'] = false;
		}
		if( base.showEnabled ) {
			options['where']['images']['enabled'] = true;
		}
		console.log("showImages -> start{"+JSON.stringify(options)+"}");
		
		$.ajax({
			url: '/api/v1/images.json',
			type: 'GET',
			data: options,
			success: base.receivedImages
		});
	};
	
	base.receivedImages = function(xhr,msg,data) {
		if( base.markers ) {
			$.each(base.markers, function(k,v) {
				v.setMap(null);
			});
		}
		base.markers = [];
		$.each(data.responseJSON, function(key,val) {
			var icon = '/assets/' + (val.pre?'blue-dot':'red-dot') + '.png';
			var marker = new google.maps.Marker({
				position: new google.maps.LatLng(val.latitude,val.longitude), 
				map: base.map,
				icon: icon
			});
			google.maps.event.addListener(marker, 'mouseover', function() {
				base.requestImageDetail(val.id);
			});
			base.markers.push(marker);
		});
		
		console.log("showImages -> success");
	};
	
	base.requestImageDetail = function(imageId) {
		var options = {
			only: 'id,taken_at,latitude,longitude,pre',
			include: {
				annotations: {
					only: 'id,tag_id',
					include: {
						tag: {
							only: 'id,name,regime'
						}
					}
				},
				matches: {
					only: 'id,pre_image_id,post_image_id'
				}
			}
		};
		$.ajax({
			url: '/api/v1/images/' + imageId + '.json',
			data: options,
			success: base.showImageDetail
		});
	};
	
	base.showImageDetail = function(xhr,msg,data) {
		$('#detail').
			html(HandlebarsTemplates['image'](base.transformResponse(data.responseJSON))).
			show();
		base.initEvents();
	};
	
	base.transformResponse = function(json) {
		var regimes = [];
		$.each(json.annotations, function(k,e) {
			if( e.tag.regime ) {
				regimes.push(e);
			}
		});
		var annotations = [];
		$.each(json.annotations, function(k,e) {
			if( !e.tag.regime ) {
				annotations.push(e);
			}
		});
		var rsp = {
			latitude: json.latitude,
			longitude: json.longitude,
			regimes: {
				count: regimes.length,
				uniques: base.uniquesFor(regimes, function(e) {return e.tag.name;})
			},
			annotations: {
				count: json.annotations.length,
				uniques: base.uniquesFor(annotations, function(e) {return e.tag.name;})
			},
			matches: {
				count: json.matches.length,
				uniques: base.uniquesFor(json.matches, function(e) {return e.pre_image_id;})
			}
		};
		return rsp;
	};
	
	base.uniquesFor = function(data,comparator) {
		var counts = {};
		if( data!=null ) {
			$.each(data, function(k,e) {
				var val = comparator(e);
				if( counts[val]==null ) {
					counts[val] = 1;
				}else{
					counts[val]++;
				}
			});
		}
		var uniques = [];
		var keys = Object.keys(counts);
		if( keys!=null ) {
			$.each(keys, function(k,e) {
				var val = counts[e];
				uniques.push({value: e, count: val});
			});
		}
		return uniques;
	};
	
	base.showPre = showPre;
	base.showPost = showPost;
	base.showAll = showAll;
	base.showEnabled = showEnabled;
	
})(iCoast,$);
