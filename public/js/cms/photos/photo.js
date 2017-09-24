$(document).ready(function() {
	$("#sortable").sortable({
		stop: function(event, ui) {
			var id = ui.item.attr('id').substring(1);
			var pos = ui.item.index();

			$.post("/cms/photos/photo/move", { photo_id: id, position: pos })
			.always(function(data) {
				if ($(data).find("result").text() != "ok") {
					alert("Repositioning failed.");
				}
			});
		}
	});
});
