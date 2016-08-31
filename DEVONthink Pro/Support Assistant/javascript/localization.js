// Basic functionality for assisstants
// (c) 2010–2014 DEVONtechnologies, LLC

/* SIMPLE LOCALIZATION FUNCTIONS */


/* DEBUGGING OPTIONS */
var LOCALIZATION_LANGUAGE_FORCED = undefined;


/* GLOBAL VARIABLES */

var localized_strings = undefined;


// Load the localization file and store it in localized_strings
function initLocalization(url, delegate)
{
	var jsonURL = url;
	if (jsonURL == undefined || jsonURL == "")
		jsonURL = "localizable.json";

	$.get(jsonURL, function(data)
	{
		eval("localized_strings = " + data + ";");
		if (delegate != undefined)
			window[delegate](localized_strings);
	});
}

// Return the localized string for a given English string
function localizedString(stren)
{
	// If the localization is not yet loaded return English string
	if (localized_strings == undefined)
	{
		return stren;
	}

	// Find out which language the user uses
	var language = "";
	if (LOCALIZATION_LANGUAGE_FORCED != undefined)
	{
		language = LOCALIZATION_LANGUAGE_FORCED;
	}
	else if (navigator.appName == "Microsoft Internet Explorer")
	{
		var language = navigator.userLanguage.slice(0, 2);
	}
	else
	{
		var language = navigator.language;
		language = language.slice(0, 2);
	}
	
	// Search for localization
	for (i = 0; i < localized_strings.strings.length; i++)
	{
		if (localized_strings.strings[i].en == stren)
		{
			var returnString = eval("localized_strings.strings[i]." + language);
			if (returnString != "" && returnString != undefined)
				return returnString;
		}
	}

	return stren;  // No localization found, return English string
}
