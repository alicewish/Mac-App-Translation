// Basic functionality for assisstants
// (c) 2010–2014 DEVONtechnologies, LLC

/* SOME BASIC FUNCTIONALITY */

// Get form data from URL
function createRequestObject()
{
	FORM_DATA = new Object();
	separator = ',';
	query = '' + this.location;
	query = query.substring((query.indexOf('?')) + 1);

	if (query.length < 1)
	{
		return false;  // Perhaps we got some bad data?
	}
	keypairs = new Object();
	numKP = 1;
	while (query.indexOf('&') > -1)
	{
		keypairs[numKP] = query.substring(0,query.indexOf('&'));
		query = query.substring((query.indexOf('&')) + 1);
		numKP++;
	}
	keypairs[numKP] = query;
	for (i in keypairs)
	{
		keyName = keypairs[i].substring(0,keypairs[i].indexOf('='));
		keyValue = keypairs[i].substring((keypairs[i].indexOf('=')) + 1);
		while (keyValue.indexOf('+') > -1)
		{
			keyValue = keyValue.substring(0,keyValue.indexOf('+')) + ' ' + keyValue.substring(keyValue.indexOf('+') + 1);
			// Replace each '+' in data string with a space.
		}
		keyValue = unescape(keyValue);
		// Unescape non-alphanumerics
		if (FORM_DATA[keyName])
		{
			FORM_DATA[keyName] = FORM_DATA[keyName] + separator + keyValue;
		}
		else
		{
			FORM_DATA[keyName] = keyValue;
		}
	}
	return FORM_DATA;
}

function normalizedAppName(app)
{
	switch (app)
	{
		case "DEVONagent":
			return "DEVONagent Pro";
			break;
	}
	return app;
}


/* NAVIGATION FUNCTIONS */

function getThisFilename()
{
	var url = document.location.href;
	url = url.substring(0, (url.indexOf("#") == -1) ? url.length : url.indexOf("#"));  //this removes the anchor at the end
	url = url.substring(0, (url.indexOf("?") == -1) ? url.length : url.indexOf("?"));  //this removes the query after the file name
	url = url.substring(url.lastIndexOf("/") + 1, url.length);  //this removes everything before the last slash in the path
	return url;
}

// Remove a variable from a given URL
function removeVariableFromURL(url_string, variable_name)
{
    URL = String(url_string);

    var regex = new RegExp( "\\?" + variable_name + "=[^&]*&?", "gi");
    URL = URL.replace(regex,'?');
    regex = new RegExp( "\\&" + variable_name + "=[^&]*&?", "gi");
    URL = URL.replace(regex,'&');
    URL = URL.replace(/(\?|&)$/,'');
    regex = null;

    return URL;
}

// Switch to another page by maintaining all URL parameters
function switchTo(target, variable, value)
{
	var myLocation = this.location.href;
	var myNewLocation = myLocation.replace(getThisFilename(), target);
	if (variable != undefined && value != undefined)
	{
		myNewLocation = removeVariableFromURL(myNewLocation, variable);
		myNewLocation += "&" + variable + "=" + value;
	}
	window.location.replace(myNewLocation);
	return false;
}


/* CSS FUNCTIONS */

function loadResource(filename, filetype)
{
	if (filetype=="js")
	{
		//if filename is a external JavaScript file
		var fileref=document.createElement('script')
		fileref.setAttribute("type","text/javascript")
		fileref.setAttribute("src", filename)
	}
	else if (filetype=="css")
	{
		//if filename is an external CSS file
		var fileref=document.createElement("link")
		fileref.setAttribute("rel", "stylesheet")
		fileref.setAttribute("type", "text/css")
		fileref.setAttribute("href", filename)
	}
	if (typeof fileref!="undefined")
		document.getElementsByTagName("head")[0].appendChild(fileref)
}


/* STRING FUNCTIONS */

function unescapeHTML(string)
{
    var temp = document.createElement("div");
    temp.innerHTML = string;
    return temp.childNodes[0].nodeValue;
}

function shortenString(string, numberOfChars, flagHard)
{
	if (string.length > numberOfChars)
	{
		string = string.substring(0, numberOfChars);
		if (flagHard != true)
		{
			var lastSpaceIndex = string.lastIndexOf('.');
			if ((lastSpaceIndex < 0) || (string.substr(lastSpaceIndex + 1, 1) != ' ' && string.substr(lastSpaceIndex + 1, 1) != String.fromCharCode(10)))
			{
				lastSpaceIndex = string.lastIndexOf(' ');
			}
			if (lastSpaceIndex >= 0)
			{
				string = string.substring(0, lastSpaceIndex);
			}
		}
		string += " …";
	}
	return string;
}


/* CONVERSION FUNCTIONS */

function bytesToSize(bytes, precision)
{	
	var kilobyte = 1024;
	var megabyte = kilobyte * 1024;
	var gigabyte = megabyte * 1024;
	var terabyte = gigabyte * 1024;
	
	if ((bytes >= 0) && (bytes < kilobyte))
	{
		return bytes + ' B';
	}
	else if ((bytes >= kilobyte) && (bytes < megabyte))
	{
		return (bytes / kilobyte).toFixed(precision) + ' KB';
	}
	else if ((bytes >= megabyte) && (bytes < gigabyte))
	{
		return (bytes / megabyte).toFixed(precision) + ' MB';
	}
	else if ((bytes >= gigabyte) && (bytes < terabyte))
	{
		return (bytes / gigabyte).toFixed(precision) + ' GB';
	}
	else if (bytes >= terabyte)
	{
		return (bytes / terabyte).toFixed(precision) + ' TB';
	}
	else
	{
		return bytes + ' B';
	}
}