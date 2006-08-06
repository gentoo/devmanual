<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
  xmlns:str="http://exslt.org/strings"
  xmlns:exslt="http://exslt.org/common"
  extension-element-prefixes="str exslt xsl"
  exclude-result-prefixes="str exslt xsl"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:template name="lang.highlight.m4.subtokenate">
    <xsl:param name="data"/>
    <xsl:param name="nokeywords"/>

    <xsl:choose>
      <!-- Tokenate AC_.../AM_... -->
      <xsl:when test="starts-with($data, 'AC_') or starts-with($data, 'AM_')">
        <xsl:choose>
          <xsl:when test="contains($data, '(')">
            <span class="Identifier"><xsl:value-of select="substring-before($data, '(')"/></span>
            <span class="Special">(</span>
            <xsl:call-template name="lang.highlight.m4.subtokenate">
              <xsl:with-param name="data" select="substring-after($data, '(')"/>
              <xsl:with-param name="nokeywords" select="$nokeywords"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <span class="Identifier"><xsl:value-of select="$data"/></span>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

      <xsl:when test="starts-with($data, '(')">
        <span class="Special">(</span>
        <xsl:call-template name="lang.highlight.m4.subtokenate">
          <xsl:with-param name="data" select="substring-after($data, '(')"/>
          <xsl:with-param name="nokeywords" select="$nokeywords"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="starts-with($data, '[')">
        <span class="Special">[</span>
        <xsl:call-template name="lang.highlight.m4.subtokenate">
          <xsl:with-param name="data" select="substring-after($data, '[')"/>
          <xsl:with-param name="nokeywords" select="$nokeywords"/>
        </xsl:call-template>        
      </xsl:when>

      <xsl:when test="substring($data, string-length($data)) = ')'">
        <xsl:call-template name="lang.highlight.m4.subtokenate">
          <xsl:with-param name="data" select="substring($data, 1, string-length($data)-1)"/>
          <xsl:with-param name="nokeywords" select="$nokeywords"/>
        </xsl:call-template>        
        <span class="Special">)</span>
      </xsl:when>

      <xsl:when test="substring($data, string-length($data)-1) = '],'">
        <xsl:call-template name="lang.highlight.m4.subtokenate">
          <xsl:with-param name="data" select="substring($data, 1, string-length($data)-2)"/>
          <xsl:with-param name="nokeywords" select="$nokeywords"/>
        </xsl:call-template>        
        <span class="Special">],</span>
      </xsl:when>

      <xsl:when test="substring($data, string-length($data)) = ','">
        <xsl:call-template name="lang.highlight.m4.subtokenate">
          <xsl:with-param name="data" select="substring($data, 1, string-length($data)-1)"/>
          <xsl:with-param name="nokeywords" select="$nokeywords"/>
        </xsl:call-template>        
        <span class="Special">,</span>
      </xsl:when>

      <xsl:when test="string(number($data)) != 'NaN'">
        <span class="Constant"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <xsl:when test="$nokeywords = 'True'">
        <xsl:value-of select="$data"/>
      </xsl:when>

      <!-- sh grammar -->
      <xsl:when test="$data = ';' or $data = 'if' or $data = 'then' or $data = 'fi' or $data = '-ge' or $data = '-lt' or $data = '-le' or
                      $data = '-gt' or $data = 'elif' or $data = 'else' or $data = 'eval' or $data = 'unset' or $data = 'rm' or $data = 'cat' or
                      $data = 'while' or $data = 'do' or $data = 'read' or $data = 'done' or $data = 'make' or $data = 'echo' or $data = 'cd' or $data = 'local' or $data = 'return' or
                      $data = 'for' or $data = 'case' or $data = 'esac' or $data = 'in' or $data = '-n' or $data = '[' or $data = ']' or
                      $data = '-z' or $data = '-f' or $data = '&lt;&lt;-' or $data = '&gt;' or $data = 'EOF' or $data = 'test'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!-- No match return -->
      <xsl:otherwise>
        <xsl:value-of select="$data"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="lang.highlight.m4.tokenate">
    <xsl:param name="data"/>

    <!-- Only tokenize spaces, this way we preserve tabs. -->
    <xsl:variable name="tokenizedData" select="str:tokenize_plasmaroo($data, '&quot; &#9;')"/>

    <!-- Scan for quotes... -->
    <xsl:for-each select="exslt:node-set($tokenizedData)">
    <xsl:variable name="myPos" select="position()"/>
    <xsl:variable name="quotePos" select="count(../*[@delimiter='&quot;' and position() &lt; $myPos])"/>
    
    <xsl:choose>
      <xsl:when test="../*[position()=1] = 'dnl'">
        <span class="Comment"><xsl:value-of select="."/></span>
      </xsl:when>

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

      <!-- Highlight variable assignments;
		@regexp = [\w]=["']{...}['"] -->
      <xsl:when test="contains(., '=')">
        <xsl:call-template name="lang.highlight.m4.subtokenate">
          <xsl:with-param name="data" select="substring-before(., '=')"/>
        </xsl:call-template>
        <span class="Constant">=</span>
        <xsl:call-template name="lang.highlight.m4.subtokenate">
          <xsl:with-param name="data" select="substring-after(., '=')"/>
        </xsl:call-template>
      </xsl:when>

      <!-- No match return -->
      <xsl:otherwise>
        <xsl:call-template name="lang.highlight.m4.subtokenate">
	  <xsl:with-param name="data" select="."/>
	</xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
