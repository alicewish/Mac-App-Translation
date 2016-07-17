function toggleDiv(im,divID) {
	var div = document.getElementById(divID);
	var subDiv = div.getElementsByTagName('div')[0];
	if (subDiv.style.display == "none") 
	{
		im.src="images/ArrowPointingDown.png"
		subDiv.style.display = 'block';
	}
	else 
	{
		im.src="images/Forward.png"
		subDiv.style.display = 'none';
	}
}
