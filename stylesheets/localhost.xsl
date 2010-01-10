<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:docbook="http://docbook.org/ns/docbook"
	version="1.0">

<xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/xhtml/chunktoc.xsl" />


<!-- List of the configurable parameters -->
<xsl:param name="baseuri"></xsl:param>
<xsl:param name="theme-name">web/</xsl:param>
<xsl:param name="css-path">css/</xsl:param>
<xsl:param name="js-path">js/</xsl:param>
<xsl:param name="images-path">images/</xsl:param>

<xsl:template name="user.head.content">
	<!-- Include the reset Style Sheet
	     The main purposes of a reset stylesheet is to reduce browser
	     inconsistencies in things like default line heights, margins
	     and font sizes of headings, and so on. -->
	<link rel="stylesheet" type="text/css">
		<xsl:attribute name="href">
			<xsl:value-of select="$baseuri" />
			<xsl:text>stylesheets/</xsl:text>
			<xsl:value-of select="$theme-name" />
			<xsl:value-of select="$css-path" />
			<xsl:text>reset.css</xsl:text>
		</xsl:attribute>
	</link>

	<!-- Include the main Style Sheet
	     -->
	<link rel="stylesheet" type="text/css">
		<xsl:attribute name="href">
			<xsl:value-of select="$baseuri" />
			<xsl:text>stylesheets/</xsl:text>
			<xsl:value-of select="$theme-name" />
			<xsl:value-of select="$css-path" />
			<xsl:text>style.css</xsl:text>
		</xsl:attribute>
	</link>

	<!-- Include the typefacing Style Sheet
	     The main purposes of a typefacing stylesheet is to apply
	     fonts, typography metric and proportions. -->
	<link rel="stylesheet" type="text/css">
		<xsl:attribute name="href">
			<xsl:value-of select="$baseuri" />
			<xsl:text>stylesheets/</xsl:text>
			<xsl:value-of select="$theme-name" />
			<xsl:value-of select="$css-path" />
			<xsl:text>typefacing.css</xsl:text>
		</xsl:attribute>
	</link>

	<!-- Include the grid Style Sheet
	     -->
	<link rel="stylesheet" type="text/css">
		<xsl:attribute name="href">
			<xsl:value-of select="$baseuri" />
			<xsl:text>stylesheets/</xsl:text>
			<xsl:value-of select="$theme-name" />
			<xsl:value-of select="$css-path" />
			<xsl:text>grid.css</xsl:text>
		</xsl:attribute>
	</link>
</xsl:template>

<xsl:template name="user.footer.navigation">

	<!-- Include latest versione of jQuery -->
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js" />

	<!-- Include hashgrid script (http://hashgrid.com)
	     -->
	<script type="text/javascript">
		<xsl:attribute name="src">
			<xsl:value-of select="$baseuri" />
			<xsl:text>stylesheets/</xsl:text>
			<xsl:value-of select="$theme-name" />
			<xsl:value-of select="$js-path" />
			<xsl:text>hashgrid.js</xsl:text>
		</xsl:attribute>
	</script>
</xsl:template>

</xsl:stylesheet>
