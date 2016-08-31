// Basic functionality for assisstants
// (c) 2010–2014 DEVONtechnologies, LLC

/* USER INTERFACE FUNCTIONS */

// Shows or hides the spinner overlay for an element that contains a spinner
function showSpinner(frameelements, flag)
{
	$(frameelements).children(".spinner").css("visibility", flag ? "visible" : "hidden");
	$(frameelements).children(".spinner").css("opacity", flag ? "1.0" : "0.0");
}

