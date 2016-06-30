<!-- Dreamweaver source formatting profile -->

<!-- options

	INDENTION	: indention options
		ENABLE  - allows indention
		INDENT	- columns per indention
		TABS	- columns per tab character
		USE		- TABS or SPACES for indention
		ACTIVE	- active indention groups (IGROUP)

	LINES		: end-of-line options
		AUTOWRAP	- enable automatic line wrapping
		BREAK		- CRLF, CR, LF
		COLUMN		- auto wrap lines after column

	OMIT		: element omission options
		OPTIONS	- options

	ELEMENT		: element options
		CASE	- "UPPER" or "lower" case
		ALWAYS	- always use preferred element case (instead of original case)

	ATTRIBUTE	: attribute options
		CASE	- "UPPER" or "lower" case
		ALWAYS	- always use preferred attribute case (instead of original case)

-->
<?options>
<indention enable indent="4" tabs="4" use="tabs" active="1,2,3,4,5,6,7">
<lines autowrap column="1024" break="CRLF">
<omit options="0">
<element case="lower" always>
<attribute case="lower" always>
<colors text="0x00000000" tag="0x00000000" unknowntag="0x00000000" comment="0x00000000" invalid="0x00000000" object="0x00000000">
<directives break="1,0,0,1">
<directives delimiter="%3C%25=" break="0,0,0,0">	<!-- no line breaks surrounding a "<%=" script block -->

<!-- element information
	line breaks				: BREAK  = "before, inside start, inside end, after"
	indent contents			: INDENT
	indent group			: IGROUP = "indention group number" (1 through 8)
	specific name case		: NAMECASE = "CustomName"
	prevent formatting		: NOFORMAT
-->
<?elements>
<address break="1,0,0,1">
<applet break="0,1,1,0" indent>
<area break="1,0,0,1">
<article break="1,1,1,1" indent>
<aside break="1,1,1,1" indent>
<audio break="1,1,1,1" indent>
<base break="1,0,0,1">
<blockquote break="1,1,1,1" indent>
<body break="1,1,1,1">
<br break="0,0,0,1">
<canvas break="1,1,1,1" indent>
<caption break="1,0,0,1">
<center break="1,1,1,1" indent>
<cfabort break="1,0,0,1">
<cfapplet break="1,0,0,1">
<cfapplication break="1,0,0,1">
<cfassociate break="1,0,0,1">
<cfauthenticate break="1,0,0,1">
<cfbreak break="1,0,0,1">
<cfcache break="1,0,0,1">
<cfcatch break="1,1,1,1" indent>
<cfcase break="1,1,1,1">
<cfcol break="1,0,0,1">
<cfcollection break="1,0,0,1">
<cfcontent break="1,0,0,1">
<cfcookie break="1,0,0,1">
<cfdefaultcase break="1,1,1,1">
<cfdirectory break="1,0,0,1">
<cferror break="1,0,0,1">
<cfexit break="1,0,0,1">
<cffile break="1,0,0,1">
<cfform break="1,1,1,1" indent>
<cfftp break="1,0,0,1">
<cfgrid break="1,1,1,1" indent>
<cfgridcolumn break="1,0,0,1">
<cfgridrow break="1,0,0,1">
<cfgridupdate break="1,0,0,1">
<cfheader break="1,0,0,1">
<cfhtmlhead break="1,0,0,1">
<cfhttp break="1,1,1,1" indent>
<cfhttpparam break="1,0,0,1">
<cfif break="1,0,1,1" indent igroup="6">
<cfelse break="1,0,0,1" indent igroup="6">
<cfelseif break="1,0,0,1" indent igroup="6">
<cfinclude break="1,0,0,1">
<cfindex break="1,0,0,1">
<cfinput break="1,0,0,1">
<cfinsert break="1,0,0,1">
<cfldap break="1,0,0,1">
<cflocation break="1,0,0,1">
<cflock break="1,1,1,1" indent>
<cfloop break="1,1,1,1" indent noformat>
<cfmail break="1,1,1,1" indent>
<cfmodule break="1,0,0,1">
<cfobject break="1,0,0,1">
<cfoutput indent>
<cfparam break="1,0,0,1">
<cfpop break="1,0,0,1">
<cfprocparam break="1,0,0,1">
<cfprocresult break="1,0,0,1">
<cfquery break="1,1,1,1" indent noformat>
<cfregistry break="1,0,0,1">
<cfreport break="1,1,1,1" indent>
<cfscript break="1,1,1,1">
<cfschedule break="1,0,0,1">
<cfsearch break="1,0,0,1">
<cfselect break="1,1,1,1" indent>
<cfset break="1,0,0,1">
<cfsetting break="1,0,0,1">
<cfslider break="1,0,0,1">
<cfstoredproc break="1,1,1,1" indent>
<cfswitch break="1,1,1,1" indent>
<cftable break="1,1,1,1" indent>
<cfthrow break="1,0,0,1">
<cftextinput break="1,0,0,1">
<cftransaction break="1,1,1,1" indent>
<cftree break="1,1,1,1" indent>
<cftreeitem break="1,0,0,1">
<cftry break="1,1,1,1" indent>
<cfupdate break="1,0,0,1">
<dd break="1,0,0,1" indent>
<dir break="1,0,0,1" indent>
<div break="1,1,1,1" indent>
<dl break="1,0,0,1" indent>
<dt break="1,0,0,1" indent>
<embed break="0,1,1,0" indent>
<fieldset break="1,1,1,1" indent>
<figcaption break="1,1,1,1" indent>
<figure break="1,1,1,1" indent>
<footer break="1,1,1,1" indent>
<form break="1,1,1,1" indent>
<frame break="1,0,0,1">
<frameset break="1,0,0,1" indent igroup="2">
<h1 break="1,1,1,1" indent>
<h2 break="1,1,1,1" indent>
<h3 break="1,1,1,1" indent>
<h4 break="1,1,1,1" indent>
<h5 break="1,1,1,1" indent>
<h6 break="1,1,1,1" indent>
<head break="1,1,1,1" indent>
<header break="1,1,1,1" indent>
<hgroup break="1,1,1,1" indent>
<hr break="1,0,0,1">
<html break="1,1,1,1">
<ilayer break="1,0,0,1">
<input break="1,0,0,1">
<isindex break="1,0,0,1">
<layer break="1,0,0,1">
<li break="1,0,0,1">
<link break="1,0,0,1">
<map break="1,1,1,1" indent>
<menu break="1,0,0,1" indent>
<meta break="1,0,0,1">
<nav break="1,1,1,1" indent>
<noscript break="1,1,1,1" indent>
<object break="0,1,1,0" indent>
<ol break="1,1,1,1" indent>
<option break="1,0,0,1">
<output break="1,1,1,1" indent>
<p break="1,1,1,1" indent>
<param break="1,0,0,1">
<pre break="1,1,1,1" noformat>
<script break="1,1,1,1" noformat>
<section break="1,1,1,1" indent>
<select break="1,1,1,1" indent>
<mm:treecontrol break="1,1,1,1" indent>
<server break="1,0,0,1" noformat>
<style break="1,0,0,1" noformat>
<table break="1,1,1,1" indent igroup="1">
<thead break="1,1,1,1" indent>
<tbody break="1,1,1,1" indent>
<td break="1,0,0,1" igroup="1">
<textarea break="1,0,0,1" noformat>
<th break="1,0,0,1" igroup="1">
<title break="1,0,0,1">
<tr break="1,1,1,1" indent igroup="1">
<ul break="1,1,1,1" indent>
<jsp:getProperty break="1,0,0,1" namecase="jsp:getProperty">
<jsp:setProperty break="1,0,0,1" namecase="jsp:setProperty">
<jsp:useBean break="1,0,0,1" namecase="jsp:useBean">
<jsp:forward break="1,0,0,1">
<jsp:include break="1,0,0,1">
<jsp:plugin break="1,1,1,1">
<jsp:params break="1,1,1,1" indent>
<jsp:param break="1,0,0,1">
<jsp:fallback break="1,0,0,1">

<!-- attribute information
	specific name case		: NAMECASE = "CustomName"
	values follow attr case		: SAMECASE	
-->
<?attributes>
<onAbort namecase="onAbort">
<onBlur namecase="onBlur">
<onChange namecase="onChange">
<onClick namecase="onClick">
<onDragDrop namecase="onDragDrop">
<onError namecase="onError">
<onFocus namecase="onFocus">
<onKeyDown namecase="onKeyDown">
<onKeyPress namecase="onKeyPress">
<onKeyUp namecase="onKeyUp">
<onLoad namecase="onLoad">
<onMouseDown namecase="onMouseDown">
<onMouseMove namecase="onMouseMove">
<onMouseOut namecase="onMouseOut">
<onMouseOver namecase="onMouseOver">
<onMouseUp namecase="onMouseUp">
<onMove namecase="onMove">
<onReset namecase="onReset">
<onResize namecase="onResize">
<onSelect namecase="onSelect">
<onSubmit namecase="onSubmit">
<onUnload namecase="onUnload">
<onDblClick namecase="onDblClick">
<onAfterUpdate namecase="onAfterUpdate">
<onBeforeUpdate namecase="onBeforeUpdate">
<onHelp namecase="onHelp">
<onReadyStateChange namecase="onReadyStateChange">
<onScroll namecase="onScroll">
<onRowEnter namecase="onRowEnter">
<onRowExit namecase="onRowExit">
<align samecase>
<checked samecase>
<codetype samecase>
<compact samecase>
<ismap samecase>
<frame samecase>
<method samecase>
<multiple samecase>
<noresize samecase>
<noshade samecase>
<nowrap samecase>
<selected samecase>
<shape samecase>
<type samecase>
<valign samecase>
<video break="1,1,1,1" indent>
<visibility samecase>
<?end>
