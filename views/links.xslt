<?xml version="1.0" ?>
<!--
//
//  Copyright (c) by Hugo Leisink <hugo@leisink.net>
//  This file is part of the Banshee PHP framework
//  https://www.banshee-php.org/
//
//  Licensed under The MIT License
//
//-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="banshee/main.xslt" />

<!--
//
//  Links template
//
//-->
<xsl:template match="links">
<xsl:if test="@category!=''">
<h2><xsl:value-of select="@category" /></h2>
</xsl:if>
<ul>
<xsl:for-each select="link">
<li><a href="{@url}" target="_blank"><xsl:value-of select="." /></a></li>
</xsl:for-each>
</ul>
</xsl:template>

<!--
//
//  Content template
//
//-->
<xsl:template match="content">
<h1>Links</h1>
<xsl:apply-templates select="links" />
<xsl:apply-templates select="result" />
</xsl:template>

</xsl:stylesheet>
