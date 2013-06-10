$(function() {
	$("#comment").blur(function() {
		createComment(gPostId,$(this).val());
	});
});

function createComment(imageId,body) {
	$.ajax({
		type: "POST",
		url: '/comments.json',
		data: {
			comment: {
				image_id: imageId,
				body: body
			}
		},
		success: function(data, textStatus, jqxhr) {
			console.log("Added comment to image "+imageId);
		},
		error: function(jqxhr, textStatus, errorThrown) {
			alert("Unable to save comment: "+textStatus);
			console.log("Error adding comment: "+errorThrown);
		}
	});
}
