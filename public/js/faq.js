function toggle_item(id) {
	$('div#faq'+id+' div').slideToggle('normal');
	$('div#faq'+id).toggleClass('active');
}
