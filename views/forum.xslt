<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="banshee/main.xslt" />
<xsl:include href="banshee/pagination.xslt" />

<!--
//
//  Forums template
//
//-->
<xsl:template match="forums">
<div class="forums">
<xsl:for-each select="forum">
<div>
<h3><a href="/{/output/page}/{@id}"><xsl:value-of select="title" /></a> (<xsl:value-of select="topics" />)</h3>
<p><xsl:value-of select="description" /></p>
</div>
</xsl:for-each>
</div>
</xsl:template>

<!--
//
//  Forum template
//
//-->
<xsl:template match="forum">
<div class="forum">
<h2><xsl:value-of select="title" /></h2>
<table class="table table-striped table-condensed">
<thead>
<tr><th>Topic</th><th>Author</th><th>Messages</th><th>Timestamp</th></tr>
</thead>
<tbody>
<xsl:for-each select="topics/topic">
	<tr>
	<td>
		<a href="/{/output/page}/topic/{@id}"><xsl:value-of select="subject" /></a>
		<xsl:if test="unread='yes'"><span class="unread">*</span></xsl:if>
	</td>
	<td><xsl:value-of select="starter" /></td>
	<td><xsl:value-of select="messages" /></td>
	<td><xsl:value-of select="timestamp" /></td>
	</tr>
</xsl:for-each>
</tbody>
</table>
</div>

<div class="right">
<xsl:apply-templates select="pagination" />
</div>

<div class="btn-group left">
<a href="/{/output/page}/{@id}/new" class="btn btn-default">New topic</a>
<a href="/{/output/page}" class="btn btn-default">Back</a>
</div>
</xsl:template>

<!--
//
//  Topic template
//
//-->
<xsl:template match="topic">
<div class="topic">
<h2><xsl:value-of select="subject" /></h2>
<xsl:for-each select="message">
	<a name="{@id}" />
	<div class="panel panel-default">
	<div class="panel-heading">
		<div class="row">
		<div class="col-xs-5"><xsl:value-of select="author" /><xsl:if test="unread='yes'"><span class="unread">*</span></xsl:if></div>
		<div class="col-sm-2"><xsl:if test="@moderate='yes'"><a href="/cms/forum/{@id}">edit</a></xsl:if></div>
		<div class="col-sm-5"><xsl:value-of select="timestamp" /></div>
		</div>
	</div>
	<div class="panel-body"><xsl:value-of disable-output-escaping="yes" select="content" /></div>
	</div>
</xsl:for-each>

<xsl:call-template name="show_messages" />
<a name="response" />
<form action="/{/output/page}#response" method="post" class="new_response">
<input type="hidden" name="topic_id" value="{@id}" />
<xsl:if test="not(/output/user)">
<label for="username">Name:</label>
<input type="text" id="username" name="username" value="{response/username}" class="form-control" />
</xsl:if>
<label for="content">Message:</label>
<textarea id="content" name="content" class="form-control"><xsl:value-of select="response/content" /></textarea>
<xsl:call-template name="smilies" />

<div class="btn-group">
<input type="submit" name="submit_button" value="Post response" class="btn btn-default" />
<a href="/{/output/page}/{@forum_id}" class="btn btn-default">Back</a>
</div>
</form>
</div>
</xsl:template>

<!--
//
//  New topic template
//
//-->
<xsl:template match="newtopic">
<xsl:call-template name="show_messages" />
<form action="/{/output/page}" method="post" class="new_topic">
<input type="hidden" name="forum_id" value="{forum_id}" />
<xsl:if test="not(/output/user)">
<label for="username">Name:</label>
<input type="text" id="username" name="username" value="{username}" class="form-control" />
</xsl:if>
<label for="subject">Topic subject:</label>
<input type="text" id="subject" name="subject" value="{subject}" class="form-control" />
<label for="content">Message:</label>
<textarea id="content" name="content" class="form-control"><xsl:value-of select="content" /></textarea>
<xsl:call-template name="smilies" />

<div class="btn-group">
<input type="submit" name="submit_button" value="Create topic" class="btn btn-default" />
<a href="/{/output/page}/{forum_id}" class="btn btn-default">Back</a>
</div>
</form>
</xsl:template>

<!--
//
//  Smilies template
//
//-->
<xsl:template name="smilies">
<div class="smilies">
<xsl:for-each select="../smilies/smiley">
<img src="/images/smilies/{.}" onClick="show_smiley('{@text}')" />
</xsl:for-each>
</div>
</xsl:template>

<!--
//
//  Content template
//
//-->
<xsl:template match="content">
<h1>Forum</h1>
<xsl:apply-templates select="forums" />
<xsl:apply-templates select="forum" />
<xsl:apply-templates select="topic" />
<xsl:apply-templates select="newtopic" />
<xsl:apply-templates select="result" />
</xsl:template>

</xsl:stylesheet>
