$(function() {
	$(".regimes input[type='checkbox'], .changes input[type='checkbox']").change(function() {
		var checked = $(this).prop("checked");
		
		if( checked ) {
			var tagId = $(this).attr("tag_id");
			createAnnotation(gPostId,tagId);
		}else{
			var annotationId = $(this).attr("annotation_id");
			deleteAnnotation(annotationId);
		}
	});
});

function createAnnotation(imageId,tagId) {
	$.ajax({
		type: "POST",
		url: '/annotations.json',
		data: {
			annotation: {
				image_id: imageId,
				tag_id: tagId
			}
		},
		success: function(data, textStatus, jqxhr) {
			$("[tag_id='"+tagId+"']").attr("annotation_id",data.id);
			console.log("Added tag "+tagId+" to image "+imageId);
		},
		error: function(jqxhr, textStatus, errorThrown) {
			alert("Unable to save tag: "+textStatus);
			console.log("Error adding tag: "+errorThrown);
		}
	});	
}

function deleteAnnotation(annotationId) {
	$.ajax({
		type: "DELETE",
		url: "/annotations/"+annotationId,
		success: function(data, textStatus, jqxhr) {
			$("[tag_id='"+tagId+"']").attr("annotation_id",null);
		},
		error: function(jqxhr, textStatus, errorThrown) {
			alert("Unable to remove tag: "+textStatus);
			console.log("Error removing tag: "+errorThrown);
		}
	});
}
