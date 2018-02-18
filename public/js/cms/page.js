function toggle_roles(state) {
	document.getElementById("roles").style.display = state ? "block" : "none";
}

function remove_preview_page(url) {
	$.post('/cms/page', { submit_button: 'Delete preview', url: url });
}

function close_preview(preview, url) {
	remove_preview_page(url);
	$(preview).parent().parent().remove();
}

function preview_loaded(url) {
	remove_preview_page(url);
	$('div.preview iframe').contents().find('body a').each(function() {
		var href = $(this).attr('href');
		$(this).attr('href', 'javascript:alert(\'Link to ' + href + '\')');
	});
}

function set_preview_width(width) {
	$('div.preview-body').css("width", width);
}
