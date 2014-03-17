var FB_timerID = null;
var DT_timerID = null;
var ajax = new ajax();

function ajax_clear(name) {
	var elem;

	if ((elem = document.getElementById(name)) != null) {
		elem.innerHTML = "";
	}
}

function ajax_print(name, data) {
	var elem;

	if ((elem = document.getElementById(name)) != null) {
		elem.innerHTML += data;
	}
}

function ajax_setvalue(name, data) {
	var elem;

	if ((elem = document.getElementById(name)) != null) {
		elem.value = data;
	}
}

function ajax_focus(name) {
	var elem;

	if ((elem = document.getElementById(name)) != null) {
		elem.focus();
	}
}

function show_answer(result) {
	answer = result.getValue("result");
	ajax_clear("feedback");
	ajax_print("feedback", "Your answer is " + answer + ".<br>\n");

	ajax_setvalue("answer", "");
	ajax_focus("answer");

	if (FB_timerID != null) {
		clearTimeout(FB_timerID);
	}
	FB_timerID = setTimeout("ajax_clear('feedback'); FB_timerID = null;", 1500);
}

function show_records(result) {
	records = result.getRecords();
	prefix = "";
	ajax_clear("data");

	if (records["vars"] != null) {
		for (i = 0; i < records["vars"].length; i++) {
			for (j = 0; j < records["vars"][i]["var"].length; j++) {
				ajax_print("data", records["vars"][i]["var"][j] + "<br>\n");
			}
			ajax_print("data", "<br>\n");
		}
	}

	ajax_setvalue("records", "");
	ajax_focus("records");

	if (DT_timerID != null) {
		clearTimeout(DT_timerID);
	}
	DT_timerID = setTimeout("ajax_clear('data'); DT_timerID = null;", 2500);
}

function show_text(result) {
	text = result.getValue("text");

	alert(text)
}

function set_focus() {
	ajax_focus("answer");
}
