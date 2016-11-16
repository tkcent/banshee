<?xml version="1.0" ?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="../banshee/main.xslt" />
<xsl:include href="../banshee/pagination.xslt" />

<!--
//
//  Overview template
//
//-->
<xsl:template match="overview">
<xsl:for-each select="messages/message">
<div class="panel panel-default">
<div class="panel-heading">
	<div class="row">
		<div class="col-sm-7"><xsl:value-of select="subject" /></div>
		<div class="col-sm-3"><xsl:value-of select="timestamp" /></div>
		<div class="col-sm-2"><xsl:value-of select="ip_address" /></div>
	</div>
</div>
<div class="panel-body">
	<div class="row">
		<div class="col-xs-10">
			<span class="author"><xsl:value-of select="author" />:</span><xsl:value-of select="content" />
		</div>
		<div class="col-xs-2 list-group">
			<a href="/forum/topic/{topic_id}#{@id}" class="list-group-item">view</a>
			<a href="/{/output/page}/{@id}" class="list-group-item">edit</a>
			<form action="/{/output/page}" method="post">
				<input type="hidden" name="message_id" value="{@id}" />
				<input type="submit" name="submit_button" value="delete" class="list-group-item" onClick="javascript:return confirm('DELETE: Are you sure?')" />
			</form>
		</div>
	</div>
</div>
</div>
</xsl:for-each>

<div class="right">
<xsl:apply-templates select="pagination" />
</div>

<div class="btn-group left">
<a href="/cms" class="btn btn-default">Back</a>
<a href="/{/output/page}/section" class="btn btn-default">Forum sections</a>
</div>
</xsl:template>

<!--
//
//  Edit template
//
//-->
<xsl:template match="edit">
<xsl:call-template name="show_messages" />
<form action="/{/output/page}" method="post">
<input type="hidden" name="id" value="{message/@id}" />
<label for="content">Message:</label>
<textarea id="content" name="content" class="form-control"><xsl:value-of select="message/content" /></textarea>

<div class="btn-group">
<input type="submit" name="submit_button" value="Save message" class="btn btn-default" />
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
<h1><img src="/images/icons/forum.png" class="title_icon" />Forum administration</h1>
<xsl:apply-templates select="overview" />
<xsl:apply-templates select="edit" />
<xsl:apply-templates select="result" />
</xsl:template>

</xsl:stylesheet>
