<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="banshee/main.xslt" />

<!--
//
//  Contact template
//
//-->
<xsl:template match="contact">
<xsl:call-template name="show_messages" />
<form action="/{/output/page}" method="post">
<label for="name">Name:</label>
<input type="text" id="name" name="name" value="{name}" class="form-control" />
<label for="email">E-mail address:</label>
<input type="text" id="email" name="email" value="{email}" class="form-control" />
<label for="telephone">Telephone:</label>
<input type="text" id="telephone" name="telephone" value="{telephone}" class="form-control" />
<label for="comment">Comment:</label>
<textarea name="comment" class="form-control"><xsl:value-of select="comment" /></textarea>
<div class="btn-group">
<input type="submit" name="submit_button" value="Submit" class="btn btn-default" />
</div>
</form>
</xsl:template>

<!--
//
//  Content template
//
//-->
<xsl:template match="content">
<h1>Contact</h1>
<xsl:apply-templates select="contact" />
<xsl:apply-templates select="result" />
</xsl:template>

</xsl:stylesheet>
