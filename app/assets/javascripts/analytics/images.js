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
			base.markers.push(marker);
		});
		
		console.log("showImages -> success");
	};
	
	base.showPre = showPre;
	base.showPost = showPost;
	base.showAll = showAll;
	base.showEnabled = showEnabled;
	
})(iCoast,$);
