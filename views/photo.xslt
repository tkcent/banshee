<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="banshee/main.xslt" />
<xsl:include href="banshee/pagination.xslt" />

<!--
//
//  Overview template
//
//-->
<xsl:template match="overview">
<div class="albums">
<xsl:for-each select="albums/album">
<div class="album row">
	<div class="col-xs-6">
		<xsl:if test="thumbnail">
		<a href="/{/output/page}/{@id}"><img src="/{/output/page}/thumbnail_{thumbnail}.{extension}" alt="thumbnail {thumbnail}" /></a>
		</xsl:if>
	</div>
	<div class="col-xs-6">
		<div class="name"><a href="/{/output/page}/{@id}"><xsl:value-of select="name" /></a></div>
		<div class="description"><xsl:value-of select="description" /></div>
	</div>
</div>
</xsl:for-each>
</div>

<div class="clear"></div>

<div class="right">
<xsl:apply-templates select="pagination" />
</div>
</xsl:template>

<!--
//
//  Photos template
//
//-->
<xsl:template match="photos">
<p><xsl:value-of select="@info" /></p>
<div class="photos" id="gallery">
<xsl:for-each select="photo">
<div class="photo"><a href="/{/output/page}/image_{@id}.{extension}" title="{title}"><div class="box"><img src="/{/output/page}/thumbnail_{@id}.{extension}" alt="{title}" /></div></a></div>
</xsl:for-each>
</div>
<br clear="both" />

<div class="right">
<xsl:apply-templates select="pagination" />
</div>
<div class="btn-group left">
<a href="/{/output/page}" class="btn btn-default">Back</a>
</div>
<div class="clear"></div>
</xsl:template>

<!--
//
//  Result template
//
//-->
<xsl:template match="result">
<p><xsl:value-of select="." /></p>
</xsl:template>

<!--
//
//  Content template
//
//-->
<xsl:template match="content">
<h1><xsl:value-of select="title" /></h1>
<xsl:apply-templates select="overview" />
<xsl:apply-templates select="photos" />
<xsl:apply-templates select="result" />
</xsl:template>

</xsl:stylesheet>
