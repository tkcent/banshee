<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="../banshee/main.xslt" />

<!--
//
//  Overview template
//
//-->
<xsl:template match="overview">
<h2>Future polls</h2>
<table class="table table-striped table-hover table-condensed">
<thead>
<tr><th>Question</th><th>Begin</th><th>End</th></tr>
</thead>
<tbody>
<xsl:for-each select="polls/poll[@edit='yes']">
<tr class="click" onClick="javascript:document.location='/{/output/page}/{@id}'">
<td><xsl:value-of select="question" /></td>
<td><xsl:value-of select="begin" /></td>
<td><xsl:value-of select="end" /></td>
</tr>
</xsl:for-each>
</tbody>
</table>

<div class="btn-group">
<a href="/{/output/page}/new" class="btn btn-default">New poll</a>
<a href="/cms" class="btn btn-default">Back</a>
</div>

<h2 class="spacer">Active and previous polls</h2>
<table class="table table-striped table-condensed">
<thead>
<tr><th>Question</th><th>Begin</th><th>End</th></tr>
</thead>
<tbody>
<xsl:for-each select="polls/poll[@edit='no']">
<tr>
<td><xsl:value-of select="question" /></td>
<td><xsl:value-of select="begin" /></td>
<td><xsl:value-of select="end" /></td>
</tr>
</xsl:for-each>
</tbody>
</table>
</xsl:template>

<!--
//
//  Edit template
//
//-->
<xsl:template match="edit">
<xsl:call-template name="show_messages" />

<form action="/{/output/page}" method="post">
<xsl:if test="poll/@id">
<input type="hidden" name="id" value="{poll/@id}" />
</xsl:if>
<label for="question">Question:</label>
<input type="text" id="question" name="question" value="{poll/question}" class="form-control" />
<label for="first">First day:</label>
<input type="text" id="begin" name="begin" value="{poll/begin}" class="form-control datepicker" />
<label for="end">Last day:</label>
<input type="text" id="end" name="end" value="{poll/end}" class="form-control datepicker" />
<label>Answers:</label>
<xsl:for-each select="poll/answers/answer">
	<input type="text" name="answers[]" value="{.}" placeholder="Answer {@nr}" class="form-control" />
</xsl:for-each>

<div class="btn-group">
<input type="submit" name="submit_button" value="Save poll" class="btn btn-default" />
<a href="/{/output/page}" class="btn btn-default">Cancel</a>
<xsl:if test="poll/@id">
<input type="submit" name="submit_button" value="Delete poll" class="btn btn-default" onClick="javascript:return confirm('DELETE: Are you sure?')" />
</xsl:if>
</div>
</form>
</xsl:template>

<!--
//
//  Content template
//
//-->
<xsl:template match="content">
<h1><img src="/images/icons/poll.png" class="title_icon" />Poll administration</h1>
<xsl:apply-templates select="overview" />
<xsl:apply-templates select="edit" />
<xsl:apply-templates select="result" />
</xsl:template>

</xsl:stylesheet>
