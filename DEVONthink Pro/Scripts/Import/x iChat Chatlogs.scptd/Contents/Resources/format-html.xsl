<?xml version="1.0"?>

<!--
	$Id: format-html.xsl,v 1.11 2007/03/12 23:17:09 mayhewn Exp $

	Format an Adium log file as HTML

	Neil Mayhew - 17 Mar 2007
	Eric Böhnisch-Volkmann - Dec 18, 2007
-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:adium="http://purl.org/net/ulf/ns/0.4-02"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="adium">

	<xsl:output method="xml"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
		indent="yes" encoding="utf-8"/>
		
	<xsl:strip-space elements="*"/>

	<xsl:param name="title" select="'Chat'" />
	<xsl:param name="person" />

	<!-- Process chats -->
	<xsl:template match="adium:chat">
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<title><xsl:value-of select="$title"/></title>
				<style type="text/css">
					<xsl:text>
						body {
							margin:20px;
							background-color:#fff;
						}
						.event
						{
							color: #222222;
							background: #EEEEEE;
							margin-top: 2px;
							margin-bottom: 5px;
							padding: 2px;
							border: 1px solid #CCCCCC
						}
						.message_local
						{
							/* border-top: 1px solid #98B4DF; */
							background: #F7FAFF;
							padding-bottom: 2px;
							margin-bottom: 1px;
						}
						.message_remote
						{
							/* border-top: 1px solid #9EC678; */
							background: #F6FFED;
							padding-bottom: 2px;
							margin-bottom: 1px;
						}
						.message_followup_local
						{
							background: #F7FAFF;
							padding-bottom: 2px;
							margin-bottom: 1px;
						}
						.message_followup_remote
						{
							background: #F6FFED;
							padding-bottom: 2px;
							margin-bottom: 1px;
						}
						.sender_local
						{
							color: #234578; background: #CCDDFF;
							font-weight: bold;
							margin-top: 5px;
							margin-bottom: 2px;
							padding: 2px;
							border: 1px solid #98B4DF;
						}
						.sender_remote
						{
							color: #386C05; background: #BBEE99;
							font-weight: bold;
							margin-top: 5px;
							margin-bottom: 2px;
							padding: 2px;
							border: 1px solid #9EC678;
						}
						.sender
						{
							font-size: 90%;
						}
						.time
						{
							font-size: 90%;
							color: gray;
						}
						.systemtext
						{
							color: gray;
						}
					</xsl:text>
				</style>
			</head>
			<body style="font-family: sans-serif; font-size: 85%">
				<xsl:apply-templates/>
			</body>
		</html>
	</xsl:template>

	<!-- Process events -->
	<xsl:template match="adium:event">
		<div class="event">
			<xsl:value-of select="@type"/>
			<xsl:text>: </xsl:text>
			<xsl:value-of select="translate(@time, 'T', ' ')"/>
		</div>
	</xsl:template>

	<!-- Process messages -->
	<xsl:template match="adium:message">
		<!-- Record whether this is a follow-on message -->
		<xsl:variable name="prec" select="preceding-sibling::*[1]"/>
		<xsl:variable name="follow-on" select="$prec[self::adium:message] and $prec/@sender = @sender"/> <!-- true when message is a follow-on -->

		<!-- Create message div -->
		<xsl:element name="div">

		<!-- Choose which div style to use -->
		<xsl:choose>
			<xsl:when test="@sender = /adium:chat/@account">
				<xsl:choose>
					<xsl:when test="not($follow-on)">
						<xsl:attribute name="class">message_local</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">message_followup_local</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="@sender = ''">
				<xsl:attribute name="class">message_followup</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="not($follow-on)">
						<xsl:attribute name="class">message_remote</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">message_followup_remote</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>	
		</xsl:choose>
		
		<!-- Put in sender/receiver box if necessary -->
		<xsl:if test="not($follow-on)">
			<xsl:choose>
				<xsl:when test="@sender = /adium:chat/@account">
					<p class="sender_local"><span class="sender">Me</span></p>
				</xsl:when>
				<xsl:when test="@sender = ''"></xsl:when>
				<xsl:otherwise>
					<p class="sender_remote"><xsl:apply-templates select="@sender"/></p>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
					
		<!-- Process attributes -->
		<div class="meta" style="float: left; padding-right: 0.5em">
			<xsl:apply-templates select="@*[not(self::sender)]"/>
		</div>
		<!-- Process child elements etc. -->
		<xsl:choose>
			<xsl:when test="@sender = ''">
				<div class="systemtext"><xsl:apply-templates select="node()"/></div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="node()"/>
			</xsl:otherwise>
		</xsl:choose>

		</xsl:element>
	
	</xsl:template>

	<xsl:template match="@sender">
		<span class="sender">
			<xsl:choose>
				<xsl:when test=". = ''">
					<!-- <xsl:text>System message</xsl:text> -->
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$person" />
				</xsl:otherwise>
			</xsl:choose>
		</span>
	</xsl:template>

	<xsl:template match="@time">
		<span class="time">
			<xsl:value-of select="substring(., 12, 8)"/>
		</span>
	</xsl:template>
	
	<xsl:template match="@auto">
		<!-- Do nothing -->
	</xsl:template>

	<!-- Copy elements but strip off the namespace -->
	<xsl:template match="*">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates/>&#160;
		</xsl:element>
	</xsl:template>

	<!-- Copy atrributes but strip off the namespace -->
	<xsl:template match="@*">
		<xsl:attribute name="{local-name()}">
			<xsl:apply-templates/>
		</xsl:attribute>
	</xsl:template>

</xsl:stylesheet>
