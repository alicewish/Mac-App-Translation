#!/usr/bin/env python
# encoding: utf-8
"""
makeTOC.py

Created by Georg Seifert on 2010-06-23.
Copyright (c) 2010 schriftgestaltung.de. All rights reserved.
"""

import sys
import os
from xml.dom.minidom import parse, parseString, Document


def main():
	folder = "/Users/georg/Programmierung/Glyphs/Glyphs/Glyphs/en.lproj/GlyphsHelp/pgs"
	
	Alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
	
	dirlist=os.listdir(folder)
	pages = {}
	for html in dirlist:
		#print html
		
		if (html[-4:] == "html" ):
			#print "__", html
			dom = parse(os.path.join(folder,html))
			#print dom.getElementsByTagName("title")
			#print dom.getElementsByTagName("title")[0].childNodes[0].data
			#print dom.getElementsByTagName("a")[0].getAttribute("name")
			Title = dom.getElementsByTagName("title")[0].childNodes[0].data
			Name = dom.getElementsByTagName("a")[0].getAttribute("name")
			pages[Title] = Name
			if u"–" in Title:
				Index = Title.find(u"–")+2
				Title = Title[Index:].strip(" ")
				print "__new Title", Title
				pages[Title] = Name
			
	#print "pages", pages
	TOC = {}
	for key in pages:
		#value = pages[key]
		#print key
		Index = key[0].upper()
		#print Index
		if TOC.has_key(Index):
			TOC[Index].append(key)
		else:
			TOC[Index] = [key]
	#print "TOC", TOC
	
	f = open("/Users/georg/Programmierung/Glyphs/Glyphs/Glyphs/en.lproj/GlyphsHelp/toc.html", "w")
	f.write('''\
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>Glyphs Index </title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta name="template" content="index"/>
	<meta name="pagetype" content="index"/>
	<meta name="robots" content="anchors"/>
	<link href="sty/index.css" rel="stylesheet" type="text/css"/>
	<link href="sty/home_os.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" charset="utf-8">
		function go(target)
		{
			window.location = target;
			window.scrollBy(0,-60);
		}
	</script>
</head>

<body>
	<!--top navigation area-->
	<div id="navbox" class="gradient">
		<a name="toc"></a>
		<div id="navleftbox">
			<a class="navlink_left" href="help:anchor='access' bookID=Glyphs Help">Start</a>
		</div>
	</div>
	<!--closes navigation area-->
	<!--alphabet area-->
	<div id="alpharow">
		<div id="alphabox">\n''')
	
	for Letter in Alphabet:
		if TOC.has_key(Letter):
			f.write('			<span class="alphaletters"><a href="javascript:go(\'#%s\');">%s</a></span>\n' % (Letter , Letter))
		else:
			f.write('			<span class="alphaletters">%s</span>\n' % Letter )
	f.write('''\
		</div>
	</div>
	<!-- closes alphabet area --><!--list area-->
	<div id="indexlist">''')
	for Letter in Alphabet:
		if TOC.has_key(Letter):
			f.write("		<div class =\"letterhead\"><a name=\"%s\"></a>%s</div>\n" % (Letter, Letter))
			Titles = sorted(TOC[Letter])
			for Title in Titles:
				Anchor = pages[Title]
				Text = '''\
		<div class="indexitem">
			<div class="indexentrytext">
				<a href="help:anchor=%s bookID=Glyphs Help">%s</a>
			</div>
		</div>\n''' % (Anchor, Title);
				f.write(Text.encode("utf-8"))
	f.write('''\
		<br style="clear:both;" />
	</div>
	<!--closes list area-->
</body>
</html>\n''')


if __name__ == '__main__':
	main()

