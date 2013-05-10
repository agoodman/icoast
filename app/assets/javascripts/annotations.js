$(function() {
	$(".regimes input[type='checkbox'], .changes input[type='checkbox']").change(function() {
		var checked = $(this).prop("checked");
		var tagId = $(this).attr("tag_id");
		
		addTag(gPostId,tagId);
	});
});

function addTag(imageId,tagId) {
	$.ajax({
		type: "POST",
		url: '/annotations',
		data: {
			annotation: {
				image_id: imageId,
				tag_id: tagId
			}
		},
		success: function(data, textStatus, jqxhr) {
			console.log("Added tag "+tagId+" to image "+imageId);
		},
		error: function(jqxhr, textStatus, errorThrown) {
			alert("Unable to save tag: "+textStatus);
			console.log("Error adding tag: "+errorThrown);
		}
	});	
}

function removeTag(annotationId) {
	$.ajax({
		type: "DELETE",
		url: "/annotations/"+annotationId,
		success: function(data, textStatus, jqxhr) {},
		error: function(jqxhr, textStatus, errorThrown) {
			alert("Unable to remove tag: "+textStatus);
			console.log("Error removing tag: "+errorThrown);
		}
	});
}
