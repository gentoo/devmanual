<?xml version="1.0"?>
<!-- This is the EXSLT implementation of str:tokenize by Jeni Tennison,
     I've modified it to keep the tokens since we need them - plasmaroo -->

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:func="http://exslt.org/functions"
                xmlns:exsl="http://exslt.org/common"
                xmlns:str="http://exslt.org/strings"
                extension-element-prefixes="str func exsl xsl"
                exclude-result-prefixes="str func exsl xsl"
                xmlns="http://www.w3.org/1999/xhtml">

<func:function name="str:tokenize_plasmaroo">
	<xsl:param name="string" select="''" />
  <xsl:param name="delimiters" select="' &#x9;&#xA;'" />
  <xsl:choose>
    <xsl:when test="not($string)">
      <func:result select="/.." />
    </xsl:when>
    <xsl:when test="not(function-available('exsl:node-set'))">
      <xsl:message terminate="yes">
        ERROR: EXSLT - Functions implementation of str:tokenize relies on exsl:node-set().
      </xsl:message>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="tokens">
        <xsl:choose>
          <xsl:when test="not($delimiters)">
            <xsl:call-template name="str:_tokenize-characters">
              <xsl:with-param name="string" select="$string" />
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="str:_tokenize-delimiters">
              <xsl:with-param name="string" select="$string" />
              <xsl:with-param name="delimiters" select="$delimiters" />
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <func:result select="exsl:node-set($tokens)/*" />
    </xsl:otherwise>
  </xsl:choose>
</func:function>

<xsl:template name="str:_tokenize-characters">
  <xsl:param name="string" />
  <xsl:if test="$string">
    <token><xsl:value-of select="substring($string, 1, 1)" /></token>
    <xsl:call-template name="str:_tokenize-characters">
      <xsl:with-param name="string" select="substring($string, 2)" />
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template name="str:_tokenize-delimiters">
  <xsl:param name="string"/>
  <xsl:param name="delimiters"/>
  <xsl:variable name="delimiter" select="substring($delimiters, 1, 1)" />
  <xsl:choose>
    <xsl:when test="not($delimiter)">
      <token><xsl:value-of select="$string" /></token>
    </xsl:when>
    <xsl:when test="contains($string, $delimiter)">
      <xsl:if test="not(starts-with($string, $delimiter))">
        <xsl:call-template name="str:_tokenize-delimiters">
          <xsl:with-param name="string" select="substring-before($string, $delimiter)" />
          <xsl:with-param name="delimiters" select="substring($delimiters, 2)" />
        </xsl:call-template>
        <xsl:value-of select="$delimiter"/>
      </xsl:if>
      <delimiter><xsl:attribute name="delimiter"><xsl:value-of select="$delimiter"/></xsl:attribute><xsl:value-of select="$delimiter"/></delimiter>
      <xsl:call-template name="str:_tokenize-delimiters">
        <xsl:with-param name="string" select="substring-after($string, $delimiter)"/>
        <xsl:with-param name="delimiters" select="$delimiters"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="str:_tokenize-delimiters">
        <xsl:with-param name="string" select="$string" />
        <xsl:with-param name="delimiters" select="substring($delimiters, 2)" />
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
