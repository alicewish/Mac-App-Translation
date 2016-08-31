/*

Some handy methods for easier implementation of standardized form validation
(c) 2010–2014 Eric Böhnisch-Volkmann, rev. for First Steps Assistant 2010-02-10

*/

// Put an error message next to an input field
function setError(element, message)
{
    var currentElement = element;
    var newSpan;
    var newText;

    // Find parent paragraph element
    while(currentElement.tagName.toLowerCase() != "p") { currentElement = currentElement.parentNode; }

    // Add <span> tag
    newSpan = document.createElement("span");
    newSpan.setAttribute("class", "error");
    newSpan.setAttribute("name", "errormessage");
    newText = document.createTextNode(message);
    newSpan.appendChild(newText);

    currentElement.appendChild(newSpan);
}

// Remove all error messages
function removeError()
{
    var removeElements = document.getElementsByName("errormessage");

    while(removeElements.length >= 1)
    {
        (removeElements[0].parentNode).removeChild(removeElements[0]);
    }
}

// Mark an element as "to be edited"
function markField(element, marked, message)
{
    if(marked)
    {
        element.style.backgroundColor = "#bfb";
        setError(element, message);
    }
    else
    {
        element.style.backgroundColor = "#fff";
    }
}

// Check an email address for validity
function checkemail(emailaddress)
{
    var filter=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
    if(!filter.test(emailaddress)) return false;
    return true;
}

// Check a string if it's a number or not
function isnumeric(sText)
{
	var ValidChars = "0123456789.";
	var IsNumber=true;
	var Char;

	for (i = 0; i < sText.length && IsNumber == true; i++) 
	{ 
		Char = sText.charAt(i); 
		if (ValidChars.indexOf(Char) == -1) 
		{
			IsNumber = false;
		}
	}
	return IsNumber;
}