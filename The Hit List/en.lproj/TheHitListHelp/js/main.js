//
// Copyright 2014 Karelia Software LLC.
//

onload = function() {
	outlineInit();

	if (supports_history_api()) {
		window.setTimeout(function() {
			window.addEventListener('popstate', function(e) {
				var content = location.pathname.split('/').pop(-1);
				loadContent(content);
			}, false);
		}, 0.1);
	}
}

function supports_history_api() {
	return !!(window.history && history.pushState);
}

function onClick(content) {
	// Take out 'local' argument to try to get the content from the server first
	loadContent(content, 'local');

	if (supports_history_api()) {
		window.history.pushState(null, null, content);
	}

	return false;
}

function loadContent(content, source) {
	var url = null;
	if (source != 'local') {
		url = 'https://www2.karelia.com/files/thehitlist/help/mac-r1/English.lproj/content/' + content;
	}
	else {
		words = window.location.href.split('/');
		words.pop(-1);
		words.push('content/' + content);
		url = words.join('/');
	}
	var req = new XMLHttpRequest();
	req.open("GET", url, true);
	req.onerror = function() { if (source != 'local') loadContent(content, 'local'); };
	req.onreadystatechange = function() {
		if (req.readyState != 4) return;
		if (req.status < 400) {
			var div = document.getElementById('content');
			div.innerHTML = new String(req.responseText);
			div.scrollTop = 0;
		}
		else {
			req.onerror();
		}
	};

	req.send();
}

function outlineInit() {
	var elements = outlineGetTopLevelLists();
	for (var i = 0; (i < elements.length); i++) {
		outlineInitOutline(elements[i]);
	}
}

function outlineInitOutline(outline) {
	var kids = outline.childNodes;
	for (var i = 0; (i < kids.length); i++) {
		var kid = kids[i];
		if (kid.nodeName == "LI") {
			outlineInitItem(kid);
		}
	}
}

function outlineInitItem(item) {
	var kids = item.childNodes;
	var hasKids = false;
	for (var i = 0; i < kids.length; i++) {
		var kid = kids[i];
		if (kid.nodeName == "UL") {
			outlineInitOutline(kid);
			hasKids = true;
		}
	}
	if (hasKids) {
		item.style.cursor = "pointer";
		item.className = "closed";
		item.onclick = outlineItemClick;
	}
}

function outlineExpandCollapse(target) {
	var kids = target.childNodes;
	var hasKids = false;
	for (var i = 0; i < kids.length; i++) {
		var kid = kids[i];
		if (kid.nodeName == "UL") {
			hasKids = true;
		}
	}
	if (hasKids) {
		target.className = target.className == "closed" ? "open" : "closed";
	}
}

function outlineItemClick(evt) {
	evt.cancelBubble = true;
	var target = evt.target

	if (target.nodeName == 'A') {
		if (target.href && target.href != '#') {
			var tags = document.getElementsByTagName('A');

			for (var i = 0; i < tags.length; i++) {
				if (tags[i].className == 'selected') {
					tags[i].className = null;
				}
			}

			target.className = 'selected';
		}
		else {
			outlineExpandCollapse(target.parentNode);
		}
	}
	else {
		outlineExpandCollapse(target);
	}
}

function outlineGetTopLevelLists() {
	var cn = "outline";
	var elements = document.getElementsByTagName("ul");
	var length = elements.length;
	var regexp = new RegExp("(^| )" + cn + "( |$)");
	var results = new Array();
	for (var i = 0; i < length; i++) {
		if (regexp.test(elements[i].className)) {
			results.push(elements[i]);
		}
	}
	return results;
}