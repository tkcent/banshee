<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="banshee/main.xslt" />

<!--
//
//  Links template
//
//-->
<xsl:template match="links">
<ul class="links">
<xsl:for-each select="link">
<li><span class="text"><xsl:value-of select="." /></span><span class="link"><a href="{@url}" target="_blank"><xsl:value-of select="@url" /></a></span></li>
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
