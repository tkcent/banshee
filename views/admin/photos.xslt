<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="../banshee/main.xslt" />

<!--
//
//  Overview template
//
//-->
<xsl:template match="overview">
<div class="albums">
<form action="/{/output/banshee/cms_directory}/photos" method="post">
Photo album: <select name="album" onChange="javascript:submit()">
<xsl:for-each select="albums/album">
<option value="{@id}"><xsl:if test="@id=../@current"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="." /></option>
</xsl:for-each>
</select>
<input type="hidden" name="submit_button" value="album" />
</form>
</div>

<div class="photos">
<xsl:for-each select="photos/photo">
<div><a href="/{/output/banshee/cms_directory}/photos/{@id}"><img src="/photo/thumbnail_{@id}.{extension}" class="preview overview_{overview}" /></a><p><xsl:value-of select="title" /></p></div>
</xsl:for-each>
</div>
<div style="clear:both"></div>

<xsl:call-template name="show_messages" />
<form action="/{/output/banshee/cms_directory}/photos" method="post" enctype="multipart/form-data">
<table>
<tr><td>Photos:</td><td><input type="file" accept="image/*" name="photos[]" multiple="multiple" /></td></tr>
<tr><td>Overview:</td><td><input type="checkbox" name="overview" /></td></tr>
</table>
<input type="submit" name="submit_button" value="Upload photos" class="button" />
<a href="/{/output/banshee/cms_directory}" class="button">Back</a>
</form>
</xsl:template>

<!--
//
//  Edit template
//
//-->
<xsl:template match="edit">
<xsl:call-template name="show_messages" />
<form action="/{/output/banshee/cms_directory}/photos" method="post">
<input type="hidden" name="id" value="{photo/@id}" />
<img src="/photo/thumbnail_{photo/@id}.{photo/extension}" class="preview_edit" />
<table>
<tr><td>Title:</td><td><input type="text" name="title" value="{photo/title}" class="text" /></td></tr>
<tr><td>Overview:</td><td><input type="checkbox" name="overview"><xsl:if test="photo/overview='yes'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input></td></tr>
</table>
<input type="submit" name="submit_button" value="Save photo" class="button" />
<input type="submit" name="submit_button" value="Delete photo" class="button" onClick="javascript:return confirm('DELETE: Are you sure?')" />
<a href="/{/output/banshee/cms_directory}/photos" class="button">Cancel</a>
</form>
</xsl:template>

<!--
//
//  Content template
//
//-->
<xsl:template match="content">
<h1><img src="/images/icons/photos.png" class="title_icon" />Photo administration</h1>
<xsl:apply-templates select="overview" />
<xsl:apply-templates select="edit" />
<xsl:apply-templates select="result" />
</xsl:template>

</xsl:stylesheet>
