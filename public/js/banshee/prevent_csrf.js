function prevent_csrf(name, secret) {
	$('form').prepend('<input type="hidden" name="' + name + '" value="' + secret + '" />');
}
