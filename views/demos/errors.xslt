<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="../banshee/main.xslt" />

<xsl:template match="content">
<h1>Error messages</h1>
<p>This page demonstrates what (internal) errors and messages look like. Internal errors are only shown when the website is in debug mode. Otherwise, they are sent by e-mail to the webmaster.</p>

<a href="/demos" class="button">Back</a>
</xsl:template>

</xsl:stylesheet>
