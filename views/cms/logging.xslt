<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="../banshee/main.xslt" />

<!--
//
//  Graph template
//
//-->
<xsl:template match="graph">
<div class="graph" onMouseOut="javascript:clear_info('{@id}')">
<h2><xsl:value-of select="@title" /></h2>
<div class="row">
<div class="col-xs-4">max: <xsl:value-of select="@max" /></div>
<div class="col-xs-4" id="count_{@id}"></div>
<div class="col-xs-4" id="day_{@id}"></div>
</div>
<table class="bars"><tr>
<xsl:for-each select="item">
<td><a href="/{/output/page}/{date}"><div style="height:{../../height}px" onMouseOver="javascript:set_info('{../@id}', '{count}', '{day}')">
<div class="weekend_{weekend}" style="height:{height}px"></div>
</div></a></td>
</xsl:for-each>
</tr></table>
</div>
</xsl:template>

<!--
//
//  Deselect template
//
//-->
<xsl:template match="deselect">
<h2>Selected day: <xsl:value-of select="." /></h2>
<p class="deselect"><a href="/{/output/page}">Remove day selection</a></p>
</xsl:template>

<!--
//
//  Pages template
//
//-->
<xsl:template match="pages">
<div class="list pages">
<h2>Top pages</h2>
<xsl:for-each select="page">
<div class="entry"><xsl:value-of select="page" /> (<xsl:value-of select="count" />)</div>
</xsl:for-each>
</div>
</xsl:template>

<!--
//
//  Search template
//
//-->
<xsl:template match="search">
<div class="list search">
<h2>Search queries</h2>
<xsl:for-each select="query">
<div class="entry"><xsl:value-of select="query" /> (<xsl:value-of select="count" />)</div>
</xsl:for-each>
</div>
</xsl:template>

<!--
//
//  Info template
//
//-->
<xsl:template match="info">
<div class="col-sm-4">
<div class="list">
<xsl:for-each select="item">
<div class="entry"><div class="percentage" style="width:{percentage}%"><xsl:value-of select="item" />: <xsl:value-of select="percentage" />% (<xsl:value-of select="count" />)</div></div>
</xsl:for-each>
</div>
</div>
</xsl:template>

<!--
//
//  Client template
//
//-->
<xsl:template match="client">
<div class="client">
<h2>Client information</h2>
<div class="row">
<xsl:apply-templates select="info" />
</div>
</div>
</xsl:template>

<!--
//
//  Referers template
//
//-->
<xsl:template match="referers">
<div class="list referers">
<h2>Referers</h2>
<xsl:for-each select="host">
<xsl:variable name="id" select="position()" />
<div class="entry" onClick="javascript:$('.ref{$id}').slideToggle('normal')">
	<xsl:value-of select="@hostname" /> (<xsl:value-of select="@total" /> / <xsl:value-of select="@count" />)
</div>
<div class="referer ref{$id}"><ul>
	<xsl:for-each select="referer">
	<li><a href="{url}" target="_blank"><xsl:value-of select="url" /></a> (<xsl:value-of select="count" />)
	</li>
	</xsl:for-each>
	<form action="/{/output/page}/{../../deselect/@date}" method="post" onSubmit="javascript:return confirm('DELETE: Are you sure?')">
		<input type="hidden" name="hostname" value="{@hostname}" />
		<input type="submit" name="submit_button" value="delete" />
	</form>
</ul></div>
</xsl:for-each>
</div>
</xsl:template>

<!--
//
//  Content template
//
//-->
<xsl:template match="content">
<h1><img src="/images/icons/logging.png" class="title_icon" />Logging</h1>
<xsl:apply-templates select="graph" />
<xsl:apply-templates select="deselect" />

<div class="row">
<div class="col-sm-6">
<xsl:apply-templates select="pages" />
</div>
<div class="col-sm-6">
<xsl:apply-templates select="search" />
</div>
</div>

<xsl:apply-templates select="client" />
<xsl:apply-templates select="referers" />
<xsl:apply-templates select="result" />
<div class="btn-group">
<a href="/cms" class="btn btn-default">Back</a>
</div>
</xsl:template>

</xsl:stylesheet>
