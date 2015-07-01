<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="banshee/main.xslt" />

<!--
//
//  List template
//
//-->
<xsl:template match="list">
<div class="list">
<xsl:for-each select="appointment">
<div class="summary" onClick="javascript:$('.content{@id}').slideToggle('normal')">
<div class="title"><xsl:value-of select="title" /></div>
<div class="date"><xsl:value-of select="begin" /> - <xsl:value-of select="end" /></div>
</div>

<div class="content content{@id}">
<xsl:value-of disable-output-escaping="yes" select="content" />
</div>
</xsl:for-each>
</div>

<div class="btn-group">
<a href="/{/output/page}" class="btn btn-default">Back</a>
</div>
</xsl:template>

<!--
//
//  Month template
//
//-->
<xsl:template match="month">
<div class="row">
<div class="col-sm-6"><h2><xsl:value-of select="@title" /></h2></div>
<div class="col-sm-6"><div class="btn-group">
	<a href="/{/output/page}/list" class="btn btn-xs btn-primary">List view</a>
	<a href="/{/output/page}/{prev}" class="btn btn-xs btn-primary">Previous month</a>
	<a href="/{/output/page}/current" class="btn btn-xs btn-primary">Current month</a>
	<a href="/{/output/page}/{next}" class="btn btn-xs btn-primary">Next month</a>
</div></div>
</div>

<table class="month" cellspacing="0">
<thead>
<tr>
<xsl:for-each select="days_of_week/day">
<th><xsl:value-of select="." /></th>
</xsl:for-each>
</tr>
</thead>
<tbody>
<xsl:for-each select="week">
	<tr class="week">
	<xsl:for-each select="day">
		<td class="day dow{@dow}{@today}">
			<div class="nr"><xsl:value-of select="@nr" /></div>
			<xsl:for-each select="appointment">
				<div class="appointment"><a href="/{/output/page}/{@id}"><xsl:value-of select="." /></a></div>
			</xsl:for-each>
		</td>
	</xsl:for-each>
	</tr>
</xsl:for-each>
</tbody>
</table>
</xsl:template>

<!--
//
//  Appointment template
//
//-->
<xsl:template match="appointment">
<div class="appointment">
<h2><xsl:value-of select="title" /></h2>
<h3><xsl:value-of select="begin" /> - <xsl:value-of select="end" /></h3>
<xsl:value-of disable-output-escaping="yes" select="content" />
</div>

<div class="btn-group">
<a href="/{/output/page}" class="btn btn-default">Back</a>
</div>
</xsl:template>

<!--
//
//  Content template
//
//-->
<xsl:template match="content">
<h1>Agenda</h1>
<xsl:apply-templates select="list" />
<xsl:apply-templates select="month" />
<xsl:apply-templates select="appointment" />
<xsl:apply-templates select="result" />
</xsl:template>

</xsl:stylesheet>
