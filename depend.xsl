<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:str="http://exslt.org/strings"
                xmlns:exslt="http://exslt.org/common"
                extension-element-prefixes="str exslt xsl"
                exclude-result-prefixes="str exslt xsl">

<xsl:import href="devbook.xsl"/>
<xsl:output method="text"/>

<xsl:template match="/">
  <xsl:variable name="refs">
    <!-- all descendants -->
    <xsl:call-template name="contents"/>
    <!-- all ancestors -->
    <xsl:call-template name="printParentDocs"/>
    <!-- previous and next documents -->
    <xsl:call-template name="findPrevious"/>
    <xsl:call-template name="findNext"/>
  </xsl:variable>
  <xsl:variable name="self" select="/devbook/@self"/>
  <xsl:value-of select="concat($self, 'index.html:')"/>
  <xsl:for-each select="exslt:node-set($refs)//a/@href[. != '#']">
    <xsl:text> </xsl:text>
    <xsl:variable name="path" select="substring-before(., 'index.html')"/>
    <!-- At this point, $path can start with zero or more ".." components
         and is relative to $self. Convert it to an absolute path. -->
    <xsl:variable name="up" select="count(str:tokenize($path, '/')[. = '..'])"/>
    <xsl:for-each select="str:tokenize($self, '/')[position() &lt;= last() - $up]">
      <xsl:value-of select="concat(., '/')"/>
    </xsl:for-each>
    <xsl:for-each select="str:tokenize($path, '/')[position() &gt; $up]">
      <xsl:value-of select="concat(., '/')"/>
    </xsl:for-each>
    <xsl:text>text.xml</xsl:text>
  </xsl:for-each>
  <xsl:value-of select="$newline"/>
</xsl:template>

</xsl:stylesheet>

<!-- Local Variables: -->
<!-- indent-tabs-mode: nil -->
<!-- fill-column: 120 -->
<!-- End: -->
