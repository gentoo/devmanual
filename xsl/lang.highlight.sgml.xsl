<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
  xmlns:str="http://exslt.org/strings"
  xmlns:exslt="http://exslt.org/common"
  extension-element-prefixes="str exslt xsl"
  exclude-result-prefixes="str exslt xsl"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:template name="lang.highlight.sgml.subtokenate">
    <xsl:param name="data"/>
    <xsl:choose>
      <xsl:when test="starts-with($data, '&lt;') or substring($data, string-length($data)) = '&gt;'">
        <span class="Identifier"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!-- No match return -->
      <xsl:otherwise>
        <xsl:value-of select="$data"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="lang.highlight.sgml.tokenate">
    <xsl:param name="data"/>

    <!-- Only tokenize spaces, this way we preserve tabs. -->
    <xsl:variable name="tokenizedData" select="str:tokenize_plasmaroo($data, '&quot; &#9;&lt;&gt;')"/>

    <!-- Scan for quotes... -->
    <xsl:for-each select="exslt:node-set($tokenizedData)">
    <xsl:variable name="myPos" select="position()"/>
    <xsl:variable name="quotePos" select="count(../*[@delimiter='&quot;' and position() &lt; $myPos])"/>
    <xsl:variable name="tagPosOpen" select="count(../*[@delimiter='&lt;' and position() &lt; $myPos])"/>
    <xsl:variable name="tagPosClosed" select="count(../*[@delimiter='&gt;' and position() &lt; $myPos])"/>
    
    <xsl:choose>
      <!-- Highlight a quote -->
      <xsl:when test=". = '&quot;'">
	<span class="Statement">&quot;</span>
      </xsl:when>

      <!-- If we're inside quotes stop here -->
      <xsl:when test="$quotePos mod 2 != 0">
        <span class="Constant">
        <xsl:value-of select="."/>
        </span>
      </xsl:when>

      <xsl:when test="contains(., '=') and $tagPosOpen != $tagPosClosed">
        <span class="Identifier"><xsl:value-of select="substring-before(., '=')"/></span>
        <span class="Constant">=</span>
        <xsl:call-template name="lang.highlight.sgml.subtokenate">      
          <xsl:with-param name="data" select="substring-after(., '=')"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="$tagPosOpen != $tagPosClosed">
        <span class="Identifier"><xsl:value-of select="."/></span>
      </xsl:when>

      <!-- No match return -->
      <xsl:otherwise>
        <xsl:call-template name="lang.highlight.sgml.subtokenate">
	  <xsl:with-param name="data" select="."/>
	</xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
