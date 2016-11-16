<?xml version="1.0" ?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="../banshee/main.xslt" />
<xsl:include href="../banshee/splitform.xslt" />

<!--
//
//  Layout templates
//
//-->
<xsl:template name="splitform_header">
<h1>Checkout</h1>
<div class="progress">
	<div class="progress-bar progress-bar-striped" role="progressbar" aria-valuenow="{current + 1}" aria-valuemin="1" aria-valuemax="{current/@max + 2}" style="width:{current/@percentage}%"><xsl:value-of select="current + 1" /> / <xsl:value-of select="current/@max + 2" /></div>
</div>
</xsl:template>

<xsl:template name="splitform_footer">
</xsl:template>

<!--
//
//  Address template
//
//-->
<xsl:template match="splitform/address">
<h2>Shipping address</h2>
<label for="name">Name:</label>
<input type="text" id="name" name="name" value="{name}" class="form-control" />
<label for="address">Address:</label>
<input type="text" id="address" name="address" value="{address}" class="form-control" />
<label for="zipcode">Zipcode:</label>
<input type="text" id="zipcode" name="zipcode" value="{zipcode}" class="form-control" />
<label for="city">City:</label>
<input type="text" id="city" name="city" value="{city}" class="form-control" />
<label for="country">Country:</label>
<input type="text" id="country" name="country" value="{country}" class="form-control" />
</xsl:template>

<!--
//
//  Payment template
//
//-->
<xsl:template match="splitform/payment">
<h2>Payment information</h2>
<label for="creditcard">Creditcard number:</label>
<input type="text" id="creditcard" name="creditcard" value="{creditcard}" class="form-control" />
</xsl:template>

<!--
//
//  Validate template
//
//-->
<xsl:template match="splitform/confirm">
<h2>Confirm order</h2>
<div class="row">
<div class="col-sm-4">
<h3>Shipping address</h3>
<div><xsl:value-of select="name" /></div>
<div><xsl:value-of select="address" /></div>
<div><xsl:value-of select="zipcode" />, <xsl:value-of select="city" /></div>
<div><xsl:value-of select="country" /></div>
</div>

<div class="col-sm-8">
<table class="table table-striped table-condensed confirm">
<thead>
<tr>
<th>Article</th>
<th>Price</th>
<th>Count</th>
</tr>
</thead>
<tbody>
<xsl:for-each select="cart/article">
<tr>
<td><a href="/webshop/{@id}"><xsl:value-of select="title" /></a></td>
<td><span class="currency"><xsl:value-of select="../@currency" disable-output-escaping="yes" /></span><xsl:value-of select="price" /></td>
<td><xsl:value-of select="quantity" /></td>
</tr>
</xsl:for-each>
</tbody>
<tfoot>
<tr>
<td>Total:</td>
<td><span class="currency"><xsl:value-of select="cart/@currency" disable-output-escaping="yes" /></span><xsl:value-of select="cart/@total" /></td>
<td><xsl:value-of select="cart/@quantity" /></td>
</tr>
</tfoot>
</table>
</div>
</div>
</xsl:template>

<!--
//
//  Process template
//
//-->
<xsl:template match="submit">
<xsl:call-template name="splitform_header" />
<p>Your order has been placed.</p>

<div class="btn-group">
<a href="/webshop" class="btn btn-default">Continue</a>
</div>
</xsl:template>

</xsl:stylesheet>
