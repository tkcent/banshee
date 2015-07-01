<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="../banshee/main.xslt" />

<!--
//
//  Newsletter template
//
//-->
<xsl:template match="newsletter">
<xsl:call-template name="show_messages" />
<form action="/{/output/page}" method="post">
<label for="title">Title:</label>
<input type="text" id="title" name="title" value="{title}" class="form-control" />
<label for="content">Content:</label>
<textarea id="content" name="content" class="form-control"><xsl:value-of select="content" /></textarea>

<div class="btn-group">
<input type="submit" name="submit_button" value="Send newsletter" class="btn btn-default" onClick="javascript:return confirm('SEND: Are you sure?')" />
<input type="submit" name="submit_button" value="Preview newsletter" class="btn btn-default" />
<a href="/cms" class="btn btn-default">Back</a>
</div>
</form>
</xsl:template>

<!--
//
//  Content template
//
//-->
<xsl:template match="content">
<img src="/images/icons/newsletter.png" class="title_icon" />
<h1>Send newsletter</h1>
<xsl:apply-templates select="newsletter" />
<xsl:apply-templates select="result" />
</xsl:template>

</xsl:stylesheet>
