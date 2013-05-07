$(function() {
	$("#prev-pre").click(function() { showPre(gPrePosition-1); });
	$("#next-pre").click(function() { showPre(gPrePosition+1); });
	$("#prev-post").click(function() { showPost(gPostPosition-1) });
	$("#next-post").click(function() { showPost(gPostPosition+1) });
	$("#find-pre").click(function() { findNearestPre(gPostPosition+1) });
	$("#find-post").click(function() { findNearestPost(gPrePosition+1) });	
});

function showPre(imageId) {
	$.getScript("/images/pre/"+imageId+".js");
}

function showPost(imageId) {
	$.getScript("/images/post/"+imageId+".js");
}

function findNearestPre(imageId) {
	$.getScript("/images/nearest_pre/"+imageId+".js");	
}

function findNearestPost(imageId) {
	$.getScript("/images/nearest_post/"+imageId+".js");
}
