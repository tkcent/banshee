<?xml version="1.0" ?>
<!--
//
//  Copyright (c) by Hugo Leisink <hugo@leisink.net>
//  This file is part of the Banshee PHP framework
//  https://www.banshee-php.org/
//
//  Licensed under The MIT License
//
//-->
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="../banshee/main.xslt" />

<!--
//
//  Overview template
//
//-->
<xsl:template match="overview">
<h2>Public pages</h2>
<table class="table table-striped table-hover table-condensed">
<thead>
<tr><th>URL</th><th>Title</th><th>Language</th><th>Visible</th></tr>
</thead>
<tbody>
<xsl:for-each select="pages/page[private=0]">
	<tr onClick="javascript:document.location='/{/output/page}/{@id}'">
	<td><xsl:value-of select="url" /></td>
	<td><xsl:value-of select="title" /></td>
	<td><xsl:value-of select="language" /></td>
	<td><xsl:value-of select="visible" /></td>
	</tr>
</xsl:for-each>
</tbody>
</table>

<h2 class="spacer">Private pages</h2>
<table class="table table-striped table-hover table-condensed">
<thead>
<tr><th>URL</th><th>Title</th><th>Language</th><th>Visible</th></tr>
</thead>
<tbody>
<xsl:for-each select="pages/page[private=1]">
	<tr onClick="javascript:document.location='/{/output/page}/{@id}'">
	<td><xsl:value-of select="url" /></td>
	<td><xsl:value-of select="title" /></td>
	<td><xsl:value-of select="language" /></td>
	<td><xsl:value-of select="visible" /></td>
	</tr>
</xsl:for-each>
</tbody>
</table>

<form action="/{/output/page}" method="post" class="clear">
<div class="btn-group">
<a href="/{/output/page}/new" class="btn btn-default">New page</a>
<a href="/cms" class="btn btn-default">Back</a>
<xsl:if test="@hiawatha='yes'">
<input type="submit" name="submit_button" value="Clear Hiawatha cache" class="btn btn-default" onClick="javascript:return confirm('CLEAR: Are you sure?')" />
</xsl:if>
</div>
</form>
</xsl:template>

<!--
//
//  Edit template
//
//-->
<xsl:template match="edit">
<xsl:call-template name="show_messages" />
<form action="/{/output/page}" method="post">
<xsl:if test="page/@id">
<input type="hidden" name="id" value="{page/@id}" />
</xsl:if>

<label for="preview">Preview:</label>
<xsl:if test="@preview">
<div id="preview" class="preview">
<div class="preview-heading">Preview of <xsl:value-of select="page/url" />
	<span class="width">
		<span class="glyphicon glyphicon-phone" aria-hidden="true" onClick="javascript:set_preview_width('320px')"></span>
		<span class="glyphicon glyphicon-unchecked" onClick="javascript:set_preview_width('720px')"></span>
		<span class="glyphicon glyphicon-blackboard" onClick="javascript:set_preview_width('')"></span>
	</span>
	<span class="glyphicon glyphicon-remove-circle close_preview" onClick="javascript:close_preview(this, '{@preview}')"></span>
</div>
<div class="preview-body"><iframe src="{@preview}" onLoad="javascript:preview_loaded('{@preview}')" /></div>
</div>
</xsl:if>

<div class="row">

<div class="col-sm-6">
<label for="url">URL:</label>
<input type="text" id="url" name="url" value="{page/url}" class="form-control" />
<label for="language">Language:</label>
<select id="language" name="language" class="form-control">
<xsl:for-each select="languages/language">
<option value="{@code}">
	<xsl:if test="@code=../../page/language"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
	<xsl:value-of select="." />
</option>
</xsl:for-each>
</select>
<label for="layout">Layout:</label>
<select id="layout" name="layout" class="form-control">
<xsl:for-each select="layouts/layout">
<option value="{.}">
	<xsl:if test=".=../@current"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
	<xsl:value-of select="." />
</option>
</xsl:for-each>
</select>
<label for="visible">Visible:</label>
<input type="checkbox" id="visible" name="visible">
<xsl:if test="page/visible='yes'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
</input>
<label for="back">Back link:</label>
<input type="checkbox" id="back" name="back">
<xsl:if test="page/back='yes'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
</input>
<label for="private">Private:</label>
<input type="checkbox" id="private" name="private" onClick="javascript:toggle_roles(this.checked)">
<xsl:if test="page/private='yes'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
</input>
<div id="roles" class="row well">
<xsl:if test="page/private='no'"><xsl:attribute name="style">display:none</xsl:attribute></xsl:if>
<xsl:for-each select="roles/role">
<div class="col-xs-6"><input type="checkbox" name="roles[{@id}]">
<xsl:if test="@checked='yes' or @id=$admin_role_id">
<xsl:attribute name="checked">checked</xsl:attribute>
</xsl:if>
<xsl:if test="@id=$admin_role_id"><xsl:attribute name="disabled">disabled</xsl:attribute></xsl:if>
</input><xsl:value-of select="." /></div>
</xsl:for-each>
</div>
</div>

<div class="col-sm-6">
<label for="title">Title:</label>
<input type="text" id="title" name="title" value="{page/title}" class="form-control" />
<label for="description">Description:</label>
<input type="text" id="description" name="description" value="{page/description}" class="form-control" />
<label for="keywords">Keywords:</label>
<input type="text" id="keywords" name="keywords" value="{page/keywords}" class="form-control" />
<label for="style">Style:</label>
<textarea id="style" name="style" class="form-control"><xsl:value-of select="page/style" /></textarea>
</div>

</div>

<label for="editor">Content:</label>
<textarea id="editor" name="content" class="form-control"><xsl:value-of select="page/content" /></textarea>

<div class="btn-group">
<input type="submit" name="submit_button" value="Save page" class="btn btn-default" />
<input type="submit" name="submit_button" value="Preview page" class="btn btn-default" />
<a href="/{/output/page}" class="btn btn-default">Cancel</a>
<xsl:if test="page/@id">
<input type="submit" name="submit_button" value="Delete page" class="btn btn-default" onClick="javascript:return confirm('DELETE: Are you sure?')" />
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
<img src="/images/icons/page.png" class="title_icon" />
<h1>Page administration</h1>
<xsl:apply-templates select="overview" />
<xsl:apply-templates select="edit" />
<xsl:apply-templates select="result" />
</xsl:template>

</xsl:stylesheet>
