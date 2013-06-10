$(function() {
	$("#new_tag").click(function() {
		createAnnotation($(this).val(), function(data) { 
			var tagId = data.id;
			add
		});
	})
});

function createTag(name,callback) {
	$.ajax({
		type: "POST",
		url: '/tags.json',
		data: {
			tag: {
				name: name
			}
		},
		success: function(data, textStatus, jqxhr) {
			console.log("Created tag "+name);
			callback(data);
		},
		error: function(jqxhr, textStatus, errorThrown) {
			alert("Unable to create tag: "+textStatus);
			console.log("Error creating tag: "+errorThrown);
		}
	});
}
