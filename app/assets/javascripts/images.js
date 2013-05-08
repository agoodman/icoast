$(function() {
	$("#prev-pre").click(function() { showPre(gPrePosition-1); });
	$("#next-pre").click(function() { showPre(gPrePosition+1); });
	$("#prev-post").click(function() { showPost(gPostPosition-1) });
	$("#next-post").click(function() { showPost(gPostPosition+1) });
	$("#find-pre").click(function() { findNearestPre(gPostPosition+1) });
	$("#find-post").click(function() { findNearestPost(gPrePosition+1) });
	
	$("#pre, #pre-thumb0, #pre-thumb1, #pre-thumb2, #post, #post-thumb0, #post-thumb1, #post-thumb2").load(function() { $(this).removeClass('loading'); });
});

function showPre(imageId) {
	loadingPre();
	$.getScript("/images/pre/"+imageId+".js");
}

function showPost(imageId) {
	loadingPost();
	$.getScript("/images/post/"+imageId+".js");
}

function findNearestPre(imageId) {
	loadingPre();
	$.getScript("/images/nearest_pre/"+imageId+".js");	
}

function findNearestPost(imageId) {
	loadingPost();
	$.getScript("/images/nearest_post/"+imageId+".js");
}

function loadingPre() {
	$('#pre, #pre-thumb0, #pre-thumb1, #pre-thumb2').addClass('loading');
}

function loadingPost() {
	$('#post, #post-thumb0, #post-thumb1, #post-thumb2').addClass('loading');	
}