// Basic functionality for assisstants
// (c) 2010–2014 DEVONtechnologies, LLC

/* RSS FEED MANAGEMENT */


// Constants for feeds used by the Welcome Assistant
var RSS_SUPPORTMATERIALS = "http://www.devontechnologies.com/fileadmin/templates/filemaker/feeds/supportmaterials.php";
var RSS_FAQ = "http://www.devontechnologies.com/fileadmin/templates/filemaker/feeds/faq.php";

var RSS_CATEGORY_TIPS = "Tips";
var RSS_CATEGORY_VIDEOS = "Screencasts";
var RSS_CATEGORY_TUTORIALS = "Tutorials";
var RSS_CATEGORY_SCRIPTS = "Scripts";
var RSS_CATEGORY_PLUGINS = "Plugins";
var RSS_CATEGORY_TEMPLATES = "Templates";

var RSS_CATEGORY_GENERAL = "General";
var RSS_CATEGORY_TROUBLESHOOTING = "Troubleshooting";

var RSS_CATEGORY_ICON_SMALL = false;
var RSS_CATEGORY_ICON_LARGE = true;

var success = false;

// Loads an RSS feed, then calls the callBack function (referenced as a string)
function loadRSSFeed(url, callBack, errorDelegate)
{
	$.get(url, function(data)
	{
		if (data.length <= 0)
		{
			window[callBack](undefined);
		}
		else
		{
			window[callBack](data);
		}
	});
}

// Loads a materials RSS feed (with ?app= parameter added)
function loadMaterialsFeed(url, productName, callBack, testflag)
{
	if (testflag == true)
	{
		console.log("TEST!");
	}
	loadRSSFeed(url + "?app=" + productName + (testflag == true ? "&test=1" : ""), callBack);
}

// Returns an array of indices of all articles matching one of the given categories (array)
function indicesForCategories(feed, categories)
{
		indices = new Array();
		for (i = 0; i < feed.getElementsByTagName("item").length; i++)
		{
			if (categories)
			{
				var category = rssArticleCategory(feed, i);
				for (j = 0; j < categories.length; j++)
				{
					if (category == categories[j])
					{
						indices.push(i);
					}
				}
			}
			else
			{
				indices.push(i);
			}
		}
		return indices;
}

// Gets an article from feed with given index
function rssArticle(feed, itemIndex)
{
	return feed.getElementsByTagName("item")[itemIndex];
}

// Gets the article's unique ID
function rssArticleUUID(feed, itemIndex)
{
	var returnValue = $(rssArticle(feed, itemIndex)).find("guid").text();
	returnValue = returnValue.substring(returnValue.lastIndexOf("#") + 1, returnValue.length);
	return returnValue == "" ? undefined : returnValue;
}

// Gets the article's title
function rssArticleTitle(feed, itemIndex)
{
	return rssArticle(feed, itemIndex).getElementsByTagName("title")[0].childNodes[0].nodeValue;
}

// Gets the article's pubDate as date
function rssArticleDate(feed, itemIndex)
{
	var dateString = rssArticle(feed, itemIndex).getElementsByTagName("pubDate")[0].childNodes[0].nodeValue;
	return new Date(dateString);
}

// Gets the article's URL
function rssArticleURL(feed, itemIndex)
{
	var returnValue = $(rssArticle(feed, itemIndex)).find("link").text();
	return returnValue == "" ? undefined : returnValue;
}

// Gets the article's enclosure URL and size
function rssArticleEnclosureURL(feed, itemIndex)
{
	var returnValue = $(rssArticle(feed, itemIndex)).find("enclosure").attr("url");
	return returnValue == "" ? undefined : returnValue;
}

function rssArticleEnclosureFilename(feed, itemIndex)
{
	var returnValue = undefined;
	var enclosureURL = $(rssArticle(feed, itemIndex)).find("enclosure").attr("url");
	if (enclosureURL != undefined && enclosureURL != "")
	{
		var URLparts = enclosureURL.split('/');
		if (URLparts.length > 0)
		{
			URLparts = URLparts[URLparts.length - 1].split('?');
			if (URLparts.length > 0)
			{
				returnValue = URLparts[0];
			}
		}
	}
	return returnValue;
}

function rssArticleEnclosureURLWithoutParameters(feed, itemIndex)
{
	var returnValue= undefined;
	var enclosureURL = $(rssArticle(feed, itemIndex)).find("enclosure").attr("url");
	if (enclosureURL != undefined && enclosureURL != "")
	{
		var URLparts = enclosureURL.split('?');
		if (URLparts.length > 0)
		{
			returnValue = URLparts[0];
		}
	}
	return returnValue;
}


// Get the 'location' from the &installpath= parameter from the enclosure URL
function rssArticleEnclosureInstallLocation(feed, itemIndex)
{
	var enclosureURL = $(rssArticle(feed, itemIndex)).find("enclosure").attr("url");
	var parameterName = "&installpath=";
	var installLocation = null;
	if (enclosureURL != undefined && enclosureURL != "")
	{
		enclosureURL = unescape(enclosureURL);
		if (enclosureURL.indexOf(parameterName) >= 0)
		{
			// Shorten the URL to just from behind the parameter; &installpath= is always the last parameter
			enclosureURL = enclosureURL.substr(enclosureURL.indexOf(parameterName) + parameterName.length);
			
			// Match with the pattern
			var pattern = /\w+(?=\/$)/g;
			installLocation = pattern.exec(enclosureURL);
		}
	}
	return installLocation;
}

function rssArticleEnclosureSize(feed, itemIndex)
{
	return rssArticle(feed, itemIndex).getElementsByTagName("enclosure")[0].getAttribute('length');
}

// Gets the article's description
function rssArticleDescription(feed, itemIndex)
{
	return rssArticle(feed, itemIndex).getElementsByTagName("description")[0].childNodes[0].nodeValue;
}

// Gets the article's category
function rssArticleCategory(feed, itemIndex)
{
	var category = rssArticle(feed, itemIndex).getElementsByTagName("category")[0].childNodes[0].nodeValue;
	if (category == undefined)
	{
		category = "";
	}
	return category;
}

// Returns the icon file name for a given category
// (string) category
// (boolean) large
function iconFileForCategory(category, large)
{
	return "images/icons/" + category + (large ? "-64" : "") + ".png";
}