<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="../banshee/main.xslt" />
<xsl:include href="../banshee/pagination.xslt" />
<!--
//
//  Overview template
//
//-->
<xsl:template match="guestbook">
<table class="list">
<tr>
<th class="author"><a href="?order=author">Author</a></th>
<th class="message"><a href="?order=message">Message</a></th>
<th class="timestamp"><a href="?order=timestamp">Timestamp</a></th>
<th class="ip_address"><a href="?order=ip_address">IP address</a></th>
<th class="delete"></th>
</tr>
<xsl:for-each select="item">
<tr>
<td><xsl:value-of select="author" /></td>
<td><xsl:value-of select="message" /></td>
<td><xsl:value-of select="timestamp" /></td>
<td><xsl:value-of select="ip_address" /></td>
<td><form action="/{/output/banshee/cms_directory}/guestbook" method="post">
<input type="hidden" name="id" value="{@id}" />
<input type="submit" name="submit_button" value="delete" class="small button" onClick="javascript:return confirm('DELETE: Are you sure?')" />
</form></td>
</tr>
</xsl:for-each>
</table>
<xsl:apply-templates select="pagination" />

<a href="/{/output/banshee/cms_directory}" class="button">Back</a>
</xsl:template>

<!--
//
//  Content template
//
//-->
<xsl:template match="content">
<h1><img src="/images/icons/guestbook.png" class="title_icon" />Guestbook administration</h1>
<xsl:apply-templates select="guestbook" />
<xsl:apply-templates select="result" />
</xsl:template>

</xsl:stylesheet>
