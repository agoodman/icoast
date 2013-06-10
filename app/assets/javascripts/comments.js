$(function() {
	$("#comment").blur(function() {
		var body = $(this).val();
		var commentId = $(this).attr("comment_id");
		if( commentId ) {
			updateComment(commentId,body);
		}else{
			createComment(gPostId,body);
		}
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
			$("#comment").attr("comment_id",data.id);
			console.log("Added comment to image "+imageId);
		},
		error: function(jqxhr, textStatus, errorThrown) {
			alert("Unable to save comment: "+textStatus);
			console.log("Error creating comment: "+errorThrown);
		}
	});
}

function updateComment(commentId,body) {
	$.ajax({
		type: "PUT",
		url: '/comments/'+commentId+'.json',
		data: {
			comment: {
				body: body
			}
		},
		success: function(data, textStatus, jqxhr) {
			console.log("Added comment to image "+imageId);
		},
		error: function(jqxhr, textStatus, errorThrown) {
			alert("Unable to update comment: "+textStatus);
			console.log("Error updating comment: "+errorThrown);
		}
	});
}
