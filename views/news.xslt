<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="banshee/main.xslt" />
<xsl:include href="banshee/pagination.xslt" />

<!--
//
//  News item template
//
//-->
<xsl:template match="news">
<div class="panel panel-default">
<div class="panel-heading">
<div class="row">
<div class="col-sm-6"><xsl:value-of select="title" /></div>
<div class="col-sm-6"><xsl:value-of select="timestamp" /></div>
</div>
</div>
<div class="panel-body">
<xsl:value-of disable-output-escaping="yes" select="content" />
</div>
</div>
</xsl:template>

<!--
//
//  Content template
//
//-->
<xsl:template match="content">
<h1>News</h1>
<div class="rsslink"><a href="/news.xml"><img src="/images/rss.png" /></a></div>
<xsl:apply-templates select="news" />
<xsl:apply-templates select="pagination" />
<xsl:apply-templates select="result" />
</xsl:template>

</xsl:stylesheet>
