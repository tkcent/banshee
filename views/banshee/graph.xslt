<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="graph">
<div class="graph" style="width:{@width}px">
<fieldset>
<xsl:if test="title"><legend><xsl:value-of select="title" /></legend></xsl:if>
<div class="info">
	<span id="label_{@id}" class="label"></span>
	<span id="value_{@id}" class="value" style="margin-left:{@maxy_width + 10}px"></span>
</div>
<div class="maxy" style="height:{@height}px ; width:{@maxy_width - 10}px">
	<xsl:value-of select="@max_y" />
</div>
<div class="bars" style="height:{@height}px ; width:{@width}px ; margin-left:{@maxy_width}px">
<xsl:for-each select="bar">
<div class="column" style="height:{../@height}px ; width:{../@bar_width - 2}px" onMouseOver="javascript:show_info({../@id}, '{@label}', '{@value}')" onMouseOut="javascript:show_info({../@id}, '', '')">
	<div class="bar" style="height:{.}px ; width:{../@bar_width - 2}px"></div>
</div>
</xsl:for-each>
</div>
</fieldset>
</div>
</xsl:template>

</xsl:stylesheet>
