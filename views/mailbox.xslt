<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="banshee/main.xslt" />

<!--
//
//  Mailbox template
//
//-->
<xsl:template match="mailbox">
<table class="table table-striped table-hover table-condensed">
<thead>
<tr><th class="subject">Subject</th><th class="from"><xsl:value-of select="@column" /></th><th class="date">Date</th></tr>
</thead>
<tbody>
<xsl:for-each select="mail">
<tr class="click {read}" onClick="javascript:document.location='/{/output/page}/{@id}'">
<td><xsl:value-of select="subject" /></td>
<td><xsl:value-of select="user" /></td>
<td><xsl:value-of select="timestamp" /></td>
</tr>
</xsl:for-each>
</tbody>
</table>

<div class="btn-group">
<a href="/{/output/page}/new" class="btn btn-default">New mail</a>
<a href="/{/output/page}{../link/@url}" class="btn btn-default"><xsl:value-of select="../link" /></a>
</div>
</xsl:template>

<!--
//
//  Mail template
//
//-->
<xsl:template match="mail">
<form action="/{/output/page}" method="post">
<input type="hidden" name="id" value="{@id}" />
<div class="panel panel-default">
<div class="panel-heading">From: <xsl:value-of select="from_user" /></div>
<div class="panel-body"><xsl:value-of disable-output-escaping="yes" select="message" /></div>
</div>

<div class="btn-group">
<xsl:if test="@actions='yes'">
<a href="/{/output/page}/reply/{@id}" class="btn btn-default">Reply</a>
</xsl:if>
<input type="submit" name="submit_button" value="Delete mail" class="btn btn-default" onClick="return confirm('DELETE: Are you sure?')" />
<a href="/{/output/page}{@back}" class="btn btn-default">Back</a>
</div>
</form>
</xsl:template>

<!--
//
//  Write template
//
//-->
<xsl:template match="write">
<xsl:call-template name="show_messages" />
<form action="/{/output/page}" method="post">
<label for="to">To:</label>
<select name="to_user_id" class="form-control">
<xsl:for-each select="recipients/recipient">
<option value="{@id}">
<xsl:if test="@id=../../mail/to_user_id">
<xsl:attribute name="selected">selected</xsl:attribute>
</xsl:if>
<xsl:value-of select="." /></option>
</xsl:for-each>
</select>
<label for="subject">Subject:</label>
<input type="text" id="subject" name="subject" value="{mail/subject}" class="form-control" />
<label for="message">Message:</label>
<textarea id="message" name="message" class="form-control"><xsl:value-of select="mail/message" /></textarea>

<div class="btn-group">
<input type="submit" name="submit_button" value="Send mail" class="btn btn-default" />
<a href="/{/output/page}" class="btn btn-default">Cancel</a>
</div>
</form>
</xsl:template>

<!--
//
//  Content template
//
//-->
<xsl:template match="content">
<h1><xsl:value-of select="title" /></h1>
<xsl:apply-templates select="mailbox" />
<xsl:apply-templates select="mail" />
<xsl:apply-templates select="write" />
<xsl:apply-templates select="result" />
</xsl:template>

</xsl:stylesheet>
