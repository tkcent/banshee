<?xml version="1.0" ?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="functions.xslt" />
<xsl:include href="layout_cms.xslt" />
<xsl:include href="layout_demo.xslt" />
<xsl:include href="layout_site.xslt" />

<xsl:output method="html" encoding="utf-8" />

<xsl:template match="/output">
<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;
</xsl:text>
<xsl:apply-templates select="layout_cms" />
<xsl:apply-templates select="layout_demo" />
<xsl:apply-templates select="layout_site" />
</xsl:template>

</xsl:stylesheet>
