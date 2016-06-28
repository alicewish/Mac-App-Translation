
var first = 1;
Event.observe( document, 'dom:loaded', setupautoopen );

function setupautoopen() {
	if ( first ) {
		first = 0;
		$('autoopen').checked = window.KeyboardMaestro.AutoOpenWelcome();
	}
}
