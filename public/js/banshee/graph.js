function show_info(graph_id, label, value) {
	if ((label_div = document.getElementById('label_' + graph_id)) == undefined) {
		return;
	}
	if ((value_div = document.getElementById('value_' + graph_id)) == undefined) {
		return;
	}

	label_div.innerHTML = label;
	value_div.innerHTML = value;
}
