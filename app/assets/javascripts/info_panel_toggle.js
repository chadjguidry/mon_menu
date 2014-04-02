// Will hide collapse the info panels on load if JavaScript is enabled.
// If no JavaScript, no problem. The content is displayed.
document.write('<style type="text/css" media="screen">.panel-body { display: none; }</style>');
// Will provide a pointer style cursor when hovered over the info panels if JavaScript is
// enabled.  If no JavaScript, no problem. The cursor isn't changed
document.write('<style type="text/css" media="screen">.panel-heading { cursor:pointer; }</style>');


// jquery to show/hide toggle info panels
$(document).ready(function(){
	// Toggle the About info
	$("#about_panel_head").click(function(){
		$("#about_panel_body").slideToggle();
	});

	// Toggle the Privacy info
	$("#privacy_panel_head").click(function(){
		$("#privacy_panel_body").slideToggle();
	});

	// Toggle the Contact inf
	$("#contact_panel_head").click(function(){
		$("#contact_panel_body").slideToggle();
	});

	// Toggle the Terms and Conditions info
	$("#terms_panel_head").click(function(){
		$("#terms_panel_body").slideToggle();
	});
});