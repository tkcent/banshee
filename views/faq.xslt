<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="banshee/main.xslt" />

<!--
//
//  Overview template
//
//-->
<xsl:template match="overview">
<xsl:for-each select="sections/section">
	<xsl:variable name="section_id" select="@id" />
	<h2><xsl:value-of select="." /></h2>
	<div class="list-group">
	<xsl:for-each select="../../faqs/faq[section_id=$section_id]">
	<div id="faq{@id}" class="list-group-item">
		<h3 class="list-group-item-heading" onClick="javascript:toggle_item({@id})"><xsl:value-of select="question" /></h3>
		<div class="list-group-item-text"><xsl:value-of disable-output-escaping="yes" select="answer" /></div>
	</div>
	</xsl:for-each>
	</div>
</xsl:for-each>
</xsl:template>

<!--
//
//  Content template
//
//-->
<xsl:template match="content">
<h1>Frequently Asked Questions</h1>
<xsl:apply-templates select="overview" />
<xsl:apply-templates select="result" />
</xsl:template>

</xsl:stylesheet>
