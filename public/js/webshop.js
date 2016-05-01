function add_to_cart(article_id) {
	$.get('/webshop/cart/add/' + article_id, function(data) {
		if ((result = $(data).find("result").text()) != "ok") {
			$.notify(result, result);
		} else {
			$('div.cart span').text($(data).find("quantity").text());
			$.notify("Added to shopping cart.", "success");
		}
	});
}
