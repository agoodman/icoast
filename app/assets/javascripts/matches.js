$(function() {
	$("input#match[type='checkbox']").change(function() {
		var checked = $(this).prop("checked");
		
		if( checked ) {
			addMatch(gPreId,gPostId);
		}else{
			var matchId = $(this).attr("match_id");
			removeMatch(matchId);
		}
	});
	
});

function addMatch(preId,postId) {
	$.ajax({
		type: "POST",
		url: '/matches',
		data: {
			match: {
				pre_image_id: preId,
				post_image_id: postId
			}
		},
		success: function(data, textStatus, jqxhr) {
			console.log("Added match for pre: "+preId+" post: "+postId);
		},
		error: function(jqxhr, textStatus, errorThrown) {
			alert("Unable to save match: "+textStatus);
			console.log("Error adding match: "+errorThrown);
		}
	});	
	
}

function removeMatch(matchId) {
	$.ajax({
		type: "DELETE",
		url: "/matches/"+matchId,
		success: function(data, textStatus, jqxhr) {},
		error: function(jqxhr, textStatus, errorThrown) {
			alert("Unable to remove match: "+textStatus);
			console.log("Error removing match: "+errorThrown);
		}
	});
}
