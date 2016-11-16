<?xml version="1.0" ?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="../banshee/main.xslt" />
<xsl:include href="../banshee/graph.xslt" />

<!--
//
//  Content template
//
//-->
<xsl:template match="content">
<h1>Graph demo</h1>
<xsl:apply-templates select="graph" />

<div class="btn-group">
<a href="/demos" class="btn btn-default">Back</a>
</div>
</xsl:template>

</xsl:stylesheet>
