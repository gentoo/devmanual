<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
  xmlns:str="http://exslt.org/strings"
  xmlns:exslt="http://exslt.org/common"
  extension-element-prefixes="str exslt xsl"
  exclude-result-prefixes="str exslt xsl"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:template name="lang.highlight.c.subtokenate">
    <xsl:param name="data"/>
    <xsl:param name="inPreProc"/>
    <xsl:choose>
      <xsl:when test="starts-with($data, '&lt;') and substring($data, string-length($data)) = '&gt;'">
        <span class="Identifier">&lt;</span><span class="Constant"><xsl:value-of select="substring($data, 2, string-length($data)-2)"/></span><span class="Identifier">&gt;</span>
      </xsl:when>

      <xsl:when test="$inPreProc = 'true'">
        <span class="PreProc"><xsl:value-of select="."/></span>
      </xsl:when>

      <!-- No match return -->
      <xsl:otherwise>
        <xsl:value-of select="$data"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="lang.highlight.c.tokenate">
    <xsl:param name="data"/>

    <!-- Only tokenize spaces, this way we preserve tabs. -->
    <xsl:variable name="tokenizedData" select="str:tokenize_plasmaroo($data, '&quot; &#9;')"/>

    <!-- Scan for quotes... -->
    <xsl:for-each select="exslt:node-set($tokenizedData)">
    <xsl:variable name="quotePos" select="count(../*[@delimiter='&quot;' and position() &lt; $myPos])"/>
    <xsl:variable name="commentOpen" select="count(str:tokenize_plasmaroo(substring-before($data, concat(' ', '/*'))))"/>
    <xsl:variable name="commentClosed" select="count(str:tokenize_plasmaroo(substring-before($data, concat(' ', '*/'))))"/>

    <xsl:variable name="macroLine">
      <xsl:if test="../*[position()=1] = '#ifdef' or ../*[position()=1] = '#include' or ../*[position()=1] = '#endif' or
                    ../*[position()=1] = '#elif' or ../*[position()=1] = '#pragma' or ../*[position()=1] = '#else' or
                    ../*[position()=1] = '#define'">true</xsl:if>
    </xsl:variable>

    <xsl:choose>
      <!-- Highlight a quote -->
      <xsl:when test=". = '&quot;'">
	<span class="Statement">&quot;</span>
      </xsl:when>

      <!-- If we're inside quotes stop here -->
      <xsl:when test="$quotePos mod 2 != 0">
        <span class="Constant">
        <xsl:call-template name="lang.highlight.ebuild.subtokenate">
          <xsl:with-param name="data"><xsl:value-of select="."/></xsl:with-param>
          <xsl:with-param name="nokeywords">True</xsl:with-param>
        </xsl:call-template>
        </span>
      </xsl:when>

      <xsl:when test="$commentOpen != $commentClosed and position() > $commentOpen">
        <span class="Comment"><xsl:value-of select="."/></span>
      </xsl:when>

      <!-- No match return -->
      <xsl:otherwise>
        <xsl:call-template name="lang.highlight.c.subtokenate">
	  <xsl:with-param name="data" select="."/>
	  <xsl:with-param name="inPreProc" select="$macroLine"/>
	</xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
