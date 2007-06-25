<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
  xmlns:str="http://exslt.org/strings"
  xmlns:exslt="http://exslt.org/common"
  extension-element-prefixes="str exslt xsl"
  exclude-result-prefixes="str exslt xsl"
  xmlns="http://www.w3.org/1999/xhtml">

<xsl:import href="xsl/str.tokenize.function.xsl"/>
<xsl:import href="xsl/lang.highlight.c.xsl"/>
<xsl:import href="xsl/lang.highlight.ebuild.xsl"/>
<xsl:import href="xsl/lang.highlight.make.xsl"/>
<xsl:import href="xsl/lang.highlight.m4.xsl"/>
<xsl:import href="xsl/lang.highlight.sgml.xsl"/>

<xsl:output method="xml" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" 
	    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" indent="yes"/>

<xsl:variable name="newline">
<xsl:text>
</xsl:text>
</xsl:variable>

  <xsl:template match="chapter">
    <h1><xsl:apply-templates select="title"/></h1>
    <xsl:apply-templates select="(body|section)"/>
  </xsl:template>

  <xsl:template match="section">
    <div class="section">
      <xsl:variable name="anchor">
        <xsl:call-template name="convert-to-anchor">
          <xsl:with-param name="data" select="title"/>
        </xsl:call-template>
      </xsl:variable>

      <h2><a name="{$anchor}"><xsl:apply-templates select="title"/></a></h2>
      <xsl:apply-templates select="(body|subsection)"/>
    </div>
  </xsl:template>

  <xsl:template match="subsection">
    <div class="section">
      <xsl:variable name="anchor">
        <xsl:call-template name="convert-to-anchor">
          <xsl:with-param name="data" select="title"/>
        </xsl:call-template>
      </xsl:variable>

      <h3><a name="{$anchor}"><xsl:apply-templates select="title"/></a></h3>
      <xsl:apply-templates select="(body|subsubsection)"/>

      <!-- If you need, change here to add more nesting levels -->
    </div>
  </xsl:template>

  <xsl:template match="subsubsection">
    <div class="section">
      <xsl:variable name="anchor">
        <xsl:call-template name="convert-to-anchor">
          <xsl:with-param name="data" select="title"/>
        </xsl:call-template>
      </xsl:variable>

      <h4><a name="{$anchor}"><xsl:apply-templates select="title"/></a></h4>
      <xsl:apply-templates select="(body)"/>

      <!-- If you need, change here to add more nesting levels -->
    </div>
  </xsl:template>

  <xsl:template match="body">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="p">
    <p>
    <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="pre">
  <pre><xsl:apply-templates/></pre>
  </xsl:template>

  <!-- Tables -->
  <!-- From the Gentoo GuideXML Stylesheet -->
  <xsl:template match="table">
  <table><xsl:apply-templates/></table>
  </xsl:template>

  <xsl:template match="tr">
  <tr><xsl:apply-templates/></tr>
  </xsl:template>

  <xsl:template match="tcolumn">
  <col width="{@width}"/>
  </xsl:template>

  <!-- Table Item -->
  <xsl:template match="ti">
    <td class="devbook">
      <xsl:if test="@colspan">
	<xsl:attribute name="colspan"><xsl:value-of select="@colspan"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="@rowspan">
	<xsl:attribute name="rowspan"><xsl:value-of select="@rowspan"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </td>
  </xsl:template>

  <!-- Table Heading -->
  <xsl:template match="th">
    <td class="devbook">
      <xsl:if test="@colspan">
	<xsl:attribute name="colspan"><xsl:value-of select="@colspan"/></xsl:attribute>
	<!-- Center only when item spans several columns as
             centering all <th> might disrupt some pages.
             We might want to use a plain html <th> tag later.
             Tip: to center a single-cell title, use <th colspan="1">
	  -->
	<xsl:attribute name="style">text-align:center</xsl:attribute>
      </xsl:if>
      <xsl:if test="@rowspan">
	<xsl:attribute name="rowspan"><xsl:value-of select="@rowspan"/></xsl:attribute>
      </xsl:if>
      <b>
	<xsl:apply-templates/>
      </b>
    </td>
  </xsl:template>
  <!-- End Table Jojo -->

  <!-- FIXME: Handle lang=... -->
  <xsl:template match="codesample">
      <xsl:variable name="ctype"><xsl:if test="@lang = 'ebuild'">Constant</xsl:if></xsl:variable>
      <xsl:variable name="numbering" select="@numbering"/>
      <xsl:variable name="lang" select="@lang"/>
      <pre><span class="{$ctype}">

      <xsl:for-each select="str:tokenize_plasmaroo(., $newline)">
        <xsl:choose>
          <xsl:when test=". = $newline">
            <xsl:if test="position() != 1"><xsl:value-of select='$newline'/></xsl:if>
            <xsl:if test="$numbering = 'lines' and position() != last()-1">
              <span style="float: left;"><xsl:number format="01"/>:<xsl:text> </xsl:text></span>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$lang = 'ebuild'">
                <xsl:call-template name="lang.highlight.ebuild.tokenate">
                  <xsl:with-param name="data" select="."/>
                </xsl:call-template>               
              </xsl:when>
              <xsl:when test="$lang = 'make'">
                <xsl:call-template name="lang.highlight.make.tokenate">
                  <xsl:with-param name="data" select="."/>
                </xsl:call-template>               
              </xsl:when>
              <xsl:when test="$lang = 'm4'">
                <xsl:call-template name="lang.highlight.m4.tokenate">
                  <xsl:with-param name="data" select="."/>
                </xsl:call-template>               
              </xsl:when>
              <xsl:when test="$lang = 'sgml'">
                <xsl:call-template name="lang.highlight.sgml.tokenate">
                  <xsl:with-param name="data" select="."/>
                </xsl:call-template>               
              </xsl:when>
              <xsl:when test="$lang = 'c'">
                <xsl:call-template name="lang.highlight.c.tokenate">
                  <xsl:with-param name="data" select="."/>
                </xsl:call-template>               
              </xsl:when>
              <xsl:otherwise>
                <xsl:message>Error: Unknown language type (<xsl:value-of select="$lang"/>)</xsl:message>
                <xsl:value-of select="."/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
      </span></pre>
  </xsl:template>

  <xsl:template match="figure">
    <div class="figure">
      <div class="image"><img alt="{@short}" src="{@link}"/></div>
      <p class="caption"><xsl:value-of select="."/></p>
    </div>
  </xsl:template>

  <!-- Lists -->
  <xsl:template match="li">
    <li><xsl:apply-templates/></li>
  </xsl:template>

  <xsl:template match="ol">
    <ol><xsl:apply-templates/></ol>
  </xsl:template>

  <xsl:template match="ul">
    <ul><xsl:apply-templates/></ul>
  </xsl:template>

  <!-- Definition Lists -->
  <xsl:template match="dl">
    <dl><xsl:apply-templates/></dl>
  </xsl:template>

  <xsl:template match="dt">
    <dt><xsl:apply-templates/></dt>
  </xsl:template>

  <xsl:template match="dd">
    <dd>
      <xsl:for-each select="p">
        <xsl:choose>
        <xsl:when test="count(../p) = 1"><xsl:apply-templates/></xsl:when>
        <xsl:when test="position() = 1"><p class="first"><xsl:apply-templates/></p></xsl:when>
        <xsl:when test="position() = last()"><p class="last"><xsl:apply-templates/></p></xsl:when>
        <xsl:otherwise><p><xsl:apply-templates/></p></xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </dd>
  </xsl:template>

  <xsl:template match="important">
    <div class="important">
    <p class="first admonition-title">Important</p>
    <p class="last"><xsl:apply-templates/></p>
    </div>
  </xsl:template>

  <xsl:template match="note">
    <div class="note">
    <p class="first admonition-title">Note</p>
    <p class="last"><xsl:apply-templates/></p>
    </div>
  </xsl:template>

  <xsl:template match="todo">
    <div class="todo">
    <p class="first admonition-title">Todo</p>
    <p class="last"><xsl:apply-templates/></p>
    </div>
  </xsl:template>

  <xsl:template match="warning">
    <div class="warning">
    <p class="first admonition-title">Warning</p>
    <p class="last"><xsl:apply-templates/></p>
    </div>
  </xsl:template>

  <xsl:template match="b">
    <b><xsl:apply-templates/></b>
  </xsl:template>

  <xsl:template match="d">
    &#8212;
  </xsl:template>

  <xsl:template match="e">
    <i><xsl:apply-templates/></i>
  </xsl:template>

  <xsl:template match="c">
    <code class="docutils literal"><span class="pre"><xsl:apply-templates/></span></code>
  </xsl:template>

  <xsl:template name="convert-to-anchor">
    <xsl:param name="data"/>
    <xsl:variable name="lcletters">abcdefghijklmnopqrstuvwxyz--</xsl:variable>
    <xsl:variable name="ucletters">ABCDEFGHIJKLMNOPQRSTUVWXYZ<xsl:text> </xsl:text>,</xsl:variable>
    <xsl:value-of select="translate($data,$ucletters,$lcletters)"/>
  </xsl:template>

  <xsl:template match="uri">
    <xsl:choose>
      <xsl:when test="starts-with(@link, '::')">
      <!-- Ideally we would work out how many levels to nest down to save a few bytes but
           going down to root level works just as well (and is faster). -->
        <xsl:variable name="relative_path_depth" select="string-length(/guide/@self)-string-length(translate(/guide/@self, '/' , ''))"/>
        <xsl:variable name="relative_path_depth_recursion">
          <xsl:call-template name="str:repeatString">
            <xsl:with-param name="count" select="$relative_path_depth"/>
            <xsl:with-param name="append">../</xsl:with-param>
	  </xsl:call-template>
	</xsl:variable>
        <xsl:choose>
          <xsl:when test="contains(@link, '##')">
            <a href="{concat($relative_path_depth_recursion, substring-after(substring-before(@link, '##'), '::'), '/index.html#', substring-after(@link, '##'))}"><xsl:value-of select="."/></a>
          </xsl:when>
          <xsl:when test="contains(@link, '#')">
            <xsl:variable name="anchor">
              <xsl:call-template name="convert-to-anchor">
                <xsl:with-param name="data" select="substring-after(@link, '#')"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="slash">
              <xsl:if test="substring(substring-before(@link, '#'), string-length(substring-before(@link, '#'))) != '/'">/</xsl:if>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test=". != ''">
                <a href="{concat($relative_path_depth_recursion, substring-after(substring-before(@link, '#'), '::'), $slash, 'index.html#', $anchor)}"><xsl:value-of select="."/></a>
              </xsl:when>
              <xsl:otherwise>
                <a href="{concat($relative_path_depth_recursion, substring-after(substring-before(@link, '#'), '::'), $slash, 'index.html#', $anchor)}"><xsl:value-of select="substring-after(@link, '#')"/></a>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="slash">
              <xsl:if test="substring(@link, string-length(@link)) != '/'">/</xsl:if>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test=". != ''">
                <a href="{concat($relative_path_depth_recursion, substring-after(@link, '::'), $slash, 'index.html')}"><xsl:value-of select="."/></a>
              </xsl:when>
              <xsl:otherwise>
                <a href="{concat($relative_path_depth_recursion, substring-after(@link, '::'), $slash, 'index.html')}"><xsl:value-of select="document(concat(/guide/@self, $relative_path_depth_recursion, substring-after(@link, '::'), '/text.xml'))/guide/chapter[1]/title"/></a>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <a href="{@link}"><xsl:value-of select="."/></a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- TOC Tree -->
  <xsl:template match="contentsTree" name="contentsTree">
    <xsl:param name="depth" select="0"/>
    <xsl:param name="maxdepth">
      <xsl:choose>
	<xsl:when test="@maxdepth"><xsl:value-of select="@maxdepth"/></xsl:when>
	<xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:param name="path">
      <xsl:choose>
        <xsl:when test="@root"><xsl:value-of select="@root"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="/guide/@self"/></xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:param name="path_rel">
      <xsl:if test="$depth = 0 and $path = '' and /guide/@self != ''">
        <xsl:call-template name="str:repeatString">
          <xsl:with-param name="count" select="string-length(/guide/@self)-string-length(translate(/guide/@self, '/' , ''))"/>
          <xsl:with-param name="append">../</xsl:with-param>
	</xsl:call-template>
      </xsl:if>
    </xsl:param>
    <xsl:param name="extraction" select="@extraction"/>
    <xsl:param name="extraction_counting"/>

    <xsl:variable name="doc_self" select="concat($path, 'text.xml')"/>
    <xsl:if test="count(document($doc_self)/guide/include) &gt; 0 and ($depth &lt; $maxdepth or $maxdepth = '0')">
    <xsl:choose>
      <xsl:when test="$extraction_counting = 1">
	<xsl:for-each select="document($doc_self)/guide/include">
	  <count value="{count(document(concat($path, @href, 'text.xml'))//*[name()=$extraction])}" path="{concat($path, @href)}">
	    <xsl:call-template name="contentsTree">
	      <xsl:with-param name="depth" select="$depth + 1"/>
	      <xsl:with-param name="maxdepth" select="$maxdepth"/>
	      <xsl:with-param name="path" select="concat($path, @href)"/>
	      <xsl:with-param name="path_rel" select="concat($path_rel, @href)"/>
	      <xsl:with-param name="extraction" select="$extraction"/>
	      <xsl:with-param name="extraction_counting" select="1"/>
	    </xsl:call-template>
	  </count>
	</xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
	<ul>
	  <xsl:for-each select="document($doc_self)/guide/include">
	    <xsl:variable name="extraction_counter_node">
	      <xsl:call-template name="contentsTree">
		<xsl:with-param name="depth" select="$depth + 1"/>
		<xsl:with-param name="maxdepth" select="$maxdepth"/>
		<xsl:with-param name="path" select="concat($path, @href)"/>
		<xsl:with-param name="path_rel" select="concat($path_rel, @href)"/>
		<xsl:with-param name="extraction" select="$extraction"/>
		<xsl:with-param name="extraction_counting" select="1"/>
	      </xsl:call-template>
	    </xsl:variable>
	    <xsl:variable name="extraction_counter" select="count(exslt:node-set($extraction_counter_node)//*[@value != 0]) + count(document(concat($path, @href, 'text.xml'))//*[name()=$extraction])"/>
	    <xsl:if test="string($extraction) = '' or $extraction_counter > 0">
	    <li>
	      <a class="reference" href="{concat($path_rel, @href, 'index.html')}"><xsl:value-of select="document(concat($path, @href, 'text.xml'))/guide/chapter[1]/title"/></a>
	      <xsl:if test="$extraction != ''">
                <ul>
                <xsl:for-each select="document(concat($path, @href, 'text.xml'))//*[name()=$extraction]">
                  <xsl:variable name="extraction_id" select="position()"/>
                  <li><xsl:apply-templates select="(//*[name()=$extraction])[position()=$extraction_id]"/><br/></li>
                </xsl:for-each>
                </ul>
              </xsl:if>
	      <xsl:call-template name="contentsTree">
		<xsl:with-param name="depth" select="$depth + 1"/>
		<xsl:with-param name="maxdepth" select="$maxdepth"/>
		<xsl:with-param name="path" select="concat($path, @href)"/>
		<xsl:with-param name="path_rel" select="concat($path_rel, @href)"/>
		<xsl:with-param name="extraction" select="$extraction"/>
	      </xsl:call-template>
	    </li>
	    </xsl:if>
	  </xsl:for-each>
	</ul>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:if>
  </xsl:template>

  <xsl:template match="/">
    <html lang="en-GB" xml:lang="en-GB" xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Gentoo Development Guide: <xsl:value-of select="/guide/chapter[1]/title"/></title>
        <xsl:variable name="relative_path_depth" select="string-length(/guide/@self)-string-length(translate(/guide/@self, '/' , ''))"/>
        <xsl:variable name="relative_path_depth_recursion">
          <xsl:call-template name="str:repeatString">
            <xsl:with-param name="count" select="$relative_path_depth"/>
            <xsl:with-param name="append">../</xsl:with-param>
          </xsl:call-template>
        </xsl:variable>	
        <link rel="stylesheet" href="{$relative_path_depth_recursion}devmanual.css" type="text/css" />
    </head>
    <body>
      <div class="main">
	<h1>Gentoo Development Guide</h1>
	<div class="navtop" style="text-align: center;">
	  <table style="border-top: 1px dashed #330066; margin-left: auto; margin-right: auto;
			width: 100%;">

	    <col width="33%" />
	    <col width="34%" />
	    <col width="33%" />
	    <tr>
	      <td style="text-align: center; border-right: 1px dashed #330066;">&#x2190; <xsl:call-template name="findPrevious"/></td>
	      <td style="text-align: center;">&#x2191; <xsl:call-template name="findParent"/> &#x2191;</td>
	      <td style="text-align: center; border-left: 1px dashed #330066;"><xsl:call-template name="findNext"/> &#x2192;</td>
	    </tr>
	  </table>
	</div>

	<div class="document">
	  <xsl:apply-templates/>
	</div>

	<div class="navbottom" style="text-align: center;">
	  <table style="border-top: 1px dashed #330066; margin-left: auto; margin-right: auto;
			width: 100%;">

	    <col width="33%" />
	    <col width="34%" />
	    <col width="33%" />
	    <tr>
	      <td style="text-align: center; border-right: 1px dashed #330066;">&#x2190; <xsl:call-template name="findPrevious"/></td>
	      <td style="text-align: center;">&#x2191; <xsl:call-template name="findParent"/> &#x2191;</td>
	      <td style="text-align: center; border-left: 1px dashed #330066;"><xsl:call-template name="findNext"/> &#x2192;</td>
	    </tr>
	  </table>
	</div>
      </div>

      <div class="footer">
	<p>
	    <a href="http://validator.w3.org/check/referer"><img src="/icons/icon_mini-xhtml.png" alt="Valid XHTML 1.0" /></a>
	    <a href="http://jigsaw.w3.org/css-validator/check/referer"><img src="/icons/icon_mini-css.png" alt="Valid CSS" /></a>
	    <a href="http://www.gentoo.org/"><img src="/icons/icon_mini-gentoo.png" alt="Powered by Gentoo" /></a>
	    <a href="http://creativecommons.org/licenses/by-sa/2.0/"><img src="/icons/icon_mini-creativecommons.png" alt="Creative Commons License" /></a>
	    <img src="/icons/icon_mini-xml.png" alt="XML Powered!"/>
	  <br />
	  <br />
	  The text of this document is distributed under the <a href="http://creativecommons.org/licenses/by-sa/2.0/">Creative Commons Attribution-ShareAlike 2.0 License</a>.
	</p>
      </div>
    </body>
    </html>
  </xsl:template>

  <xsl:template name="str:repeatString">
    <xsl:param name="string"/>
    <xsl:param name="count"/>
    <xsl:param name="append"/>
    <xsl:choose>
    <xsl:when test="$count != 0">
      <xsl:call-template name="str:repeatString">
        <xsl:with-param name="string" select="concat($string, $append)"/>
        <xsl:with-param name="count" select="$count - 1"/>
        <xsl:with-param name="append" select="$append"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$string"/>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="findNext">
    <xsl:param name="self" select="/guide/@self"/>
    <xsl:choose>
      <!-- To find the "next" node:
	   * See if this node includes any subnodes... if it does, that is
	     our next node
	   * Look at our parent and see if it includes any nodes after us, if
	     it does use it.
	   * Repeat recursively, going down parents if needed.
           * End at the root item if needed.
      -->
      <xsl:when test="count(/guide/include) &gt; 0">
	<xsl:variable name="doc" select="/guide/include[1]/@href"/>
	<a href="{concat($doc, 'index.html')}"><xsl:value-of select="document(concat(/guide/@self, $doc, 'text.xml'))/guide/chapter[1]/title"/></a>
      </xsl:when>
      <xsl:otherwise>
	<!-- This document's path -->
	<xsl:variable name="doc_self" select="concat($self, 'text.xml')"/>
	<!-- Turn the absolute path into a relative path so we can find ourselves in
	     the parent -->
        <xsl:variable name="path_self" select="concat(str:tokenize($self, '/')[last()], '/')"/>
	<xsl:variable name="index_self" select="count(document(concat($self, '../text.xml'))/guide/include[@href=$path_self]/preceding-sibling::*)+1"/>
	<!-- Go down a parent, lookup the item after us... -->
        <xsl:variable name="parentItem_lookup" select="document(concat($self, '../text.xml'))/guide/include[$index_self]/@href"/>
	<xsl:variable name="parentItem_next" select="concat(document(concat($self, '../text.xml'))/guide/@self, $parentItem_lookup)"/>
        <xsl:choose>
	  <!-- If we have an item after us, or we are at the root node (termination condition) we need to
	       not recurse any further... -->
	  <xsl:when test="$parentItem_lookup != '' or document(concat($self, '../text.xml'))/guide/@root">
	    <xsl:variable name="parentItem_actual">
	      <xsl:choose>
		<xsl:when test="$parentItem_next = ''"></xsl:when>
		<xsl:otherwise><xsl:value-of select="$parentItem_next"/></xsl:otherwise>
	      </xsl:choose>
	    </xsl:variable>
	    <!-- This is where we do a little trickery. To count how many levels we need to go down, 
                 we count how far up we currently are (remember that the absolute link we get is relative to /...) and
	         hence we can build a relative link... -->
	    <xsl:variable name="relative_path" select="$parentItem_actual"/>
	    <xsl:variable name="relative_path_depth" select="string-length(/guide/@self)-string-length(translate(/guide/@self, '/' , ''))"/>
	    <xsl:variable name="relative_path_depth_recursion">
	      <xsl:call-template name="str:repeatString">
                <xsl:with-param name="count" select="$relative_path_depth"/>
                <xsl:with-param name="append">../</xsl:with-param>
	      </xsl:call-template>
	    </xsl:variable>
	    <a href="{concat($relative_path_depth_recursion, $relative_path, 'index.html')}"><xsl:value-of select="document(concat($parentItem_actual, 'text.xml'))/guide/chapter[1]/title"/></a>
	  </xsl:when>
	  <xsl:otherwise>
	    <!-- We need to recurse downwards; so we need to strip off a directory element off our absolute path to feed
	         into the next iteration... -->
	    <xsl:variable name="relative_path_depth" select="string-length($self)-string-length(translate($self, '/' , ''))"/>
	    <xsl:variable name="relative_path_fixed">
	      <xsl:for-each select="str:tokenize_plasmaroo($self, '/')[position() &lt; (($relative_path_depth - 1)*2 + 1)]">
		<xsl:value-of select="."/>
	      </xsl:for-each>
	    </xsl:variable>
	    <xsl:call-template name="findNext">
	      <xsl:with-param name="self" select="$relative_path_fixed"/>
	    </xsl:call-template>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="getLastNode">
    <!-- This function recurses forward down nodes stopping at the very last include... -->
    <xsl:param name="root"/>
    <xsl:param name="path"/>
    <xsl:variable name="include" select="document(concat($root, $path))/guide/include[last()]/@href"/>
    <xsl:choose>
      <xsl:when test="$include">
	<xsl:call-template name="getLastNode">
          <xsl:with-param name="root" select="$root"/>
	  <xsl:with-param name="path" select="concat(substring-before($path, 'text.xml'), $include, 'text.xml')"/>
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$path"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="findPrevious">
    <xsl:choose>
      <!-- To find the "previous" node:
	   * Go down to our parent
	     * See if there are any nodes before us
	       * If we have a valid node that is before us
	       * Fully recurse up the node to get the last extremity
	     * Otherwise list the parent -->
      <xsl:when test="/guide/@root">
	<a href="#"><xsl:value-of select="/guide/chapter[1]/title"/></a>
      </xsl:when>
      <xsl:otherwise>
	<!-- This document's path -->
	<xsl:variable name="doc_self" select="concat(/guide/@self, 'text.xml')"/>
	<!-- Turn the absolute path we have into a relative path so we can find ourselves in the
	     parent -->
	<!-- FIXME: Bombproof the doc_self so it still works if it's missing a '/' on the end -->
        <xsl:variable name="path_self" select="concat(str:tokenize(/guide/@self, '/')[last()], '/')"/>
	<xsl:variable name="index_self" select="count(document(concat(/guide/@self, '../text.xml'))/guide/include[@href=$path_self]/preceding-sibling::*)-1"/>
	<xsl:choose>
	  <xsl:when test="$index_self &gt; 0">
	    <!-- Relative path of the parent -->
	    <xsl:variable name="parentItem_path" select="document(concat(/guide/@self, '../text.xml'))/guide/@self"/>
	    <!-- Previous item in the parent -->
	    <xsl:variable name="parentItem_next" select="document(concat(/guide/@self, '../text.xml'))/guide/include[$index_self]/@href"/>
	    <xsl:variable name="myItem_path">
	    <xsl:call-template name="getLastNode">
              <xsl:with-param name="root" select="$parentItem_path"/>
	      <xsl:with-param name="path" select="concat($parentItem_next, 'text.xml')"/>
	    </xsl:call-template>
	    </xsl:variable>
	    <!-- Make a relative <a> link; we need an absolute reference for the XSLT processor though... -->
	    <a href="{concat('../', substring-before($myItem_path, 'text.xml'), 'index.html')}"><xsl:value-of select="document(concat($parentItem_path, $myItem_path))/guide/chapter[1]/title"/></a>
	  </xsl:when>
	  <xsl:otherwise>
	    <a href="../index.html"><xsl:value-of select="document(concat(/guide/@self, '../text.xml'))/guide/chapter[1]/title"/></a>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="findParent">
    <xsl:choose>
    <xsl:when test="not(/guide/@root)">
      <a href="../index.html"><xsl:value-of select="document(concat(/guide/@self, '../text.xml'))/guide/chapter[1]/title"/></a>
    </xsl:when>
    <xsl:otherwise>
      <a href="#"><xsl:value-of select="/guide/chapter[1]/title"/></a>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="author">
    <dt><xsl:value-of select="@name"/><xsl:if test="@email != ''"> &lt;<a href="mailto:{@email}"><xsl:value-of select="@email"/></a>&gt;</xsl:if></dt>
    <dd><xsl:apply-templates/></dd>
  </xsl:template>

  <xsl:template match="authors">
    <dl>
    <xsl:apply-templates select="author"/>
    </dl>
  </xsl:template>
</xsl:stylesheet>
