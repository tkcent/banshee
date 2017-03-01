<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="banshee/main.xslt" />

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
