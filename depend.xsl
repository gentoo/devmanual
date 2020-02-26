<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
  xmlns:exslt="http://exslt.org/common"
  extension-element-prefixes="exslt xsl"
  exclude-result-prefixes="exslt xsl">

<xsl:import href="devbook.xsl"/>
<xsl:output method="text"/>

<xsl:template match="/">
  <xsl:variable name="refs">
    <!-- all descendants -->
    <xsl:call-template name="contentsTree"/>
    <!-- all ancestors -->
    <xsl:call-template name="printParentDocs"/>
    <!-- previous and next documents -->
    <xsl:call-template name="findPrevious"/>
    <xsl:call-template name="findNext"/>
  </xsl:variable>
  <xsl:variable name="self" select="/guide/@self"/>
  <xsl:value-of select="concat($self, 'index.html:')"/>
  <xsl:for-each select="exslt:node-set($refs)//a/@href[. != '#']">
    <!-- At this point, the path can contain ".." components and
         should be canonicalised, but string processing in XPath 1.0
         sucks (no pattern matching!). It is easier to pipe the output
         through sed instead. -->
    <xsl:value-of select="concat(' ', $self,
        substring-before(., 'index.html'), 'text.xml')"/>
  </xsl:for-each>
  <xsl:value-of select="$newline"/>
</xsl:template>

</xsl:stylesheet>
