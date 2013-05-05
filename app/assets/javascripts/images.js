$(function() {
	$("#prev-pre").click(function() { showPre(gPreImageId-1); });
	$("#next-pre").click(function() { showPre(gPreImageId+1); });
	$("#prev-post").click(function() { showPost(gPostImageId-1) });
	$("#next-post").click(function() { showPost(gPostImageId+1) });
	$("#find-pre").click(function() { findNearestPre(gPostImageId+1) });
	$("#find-post").click(function() { findNearestPost(gPreImageId+1) });	
});

function showPre(imageId) {
	$.getScript("/images/"+imageId+"/pre.js");
}

function showPost(imageId) {
	$.getScript("/images/"+imageId+"/post.js");
}

function findNearestPre(imageId) {
	$.getScript("/images/"+imageId+"/nearest_pre.js");	
}

function findNearestPost(imageId) {
	$.getScript("/images/"+imageId+"/nearest_post.js");
}
