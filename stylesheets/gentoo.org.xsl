<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:docbook="http://docbook.org/ns/docbook"
	version="1.0">

<xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/xhtml-1_1/chunktoc.xsl" />

<xsl:param name="baseuri"></xsl:param>

<xsl:template name="user.head.content">
	<link rel="stylesheet" type="text/css">
		<xsl:attribute name="href">
			<xsl:value-of select="$baseuri" />
			<xsl:text>stylesheets/reset.css</xsl:text>
		</xsl:attribute>
	</link>
	<link rel="stylesheet" type="text/css">
		<xsl:attribute name="href">
			<xsl:value-of select="$baseuri" />
			<xsl:text>stylesheets/style.css</xsl:text>
		</xsl:attribute>
	</link>
	<link rel="stylesheet" type="text/css">
		<xsl:attribute name="href">
			<xsl:value-of select="$baseuri" />
			<xsl:text>stylesheets/typefacing.css</xsl:text>
		</xsl:attribute>
	</link>
</xsl:template>

</xsl:stylesheet>
