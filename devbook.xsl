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

      <h2 id="{$anchor}"><xsl:apply-templates select="title"/></h2>
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

      <h3 id="{$anchor}"><xsl:apply-templates select="title"/></h3>
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

      <h4 id="{$anchor}"><xsl:apply-templates select="title"/></h4>
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
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <link href="https://1b9a50f4f9de4348cd9f-e703bc50ba0aa66772a874f8c7698be7.ssl.cf5.rackcdn.com/bootstrap.min.css" rel="stylesheet" media="screen" />
      <link href="https://1b9a50f4f9de4348cd9f-e703bc50ba0aa66772a874f8c7698be7.ssl.cf5.rackcdn.com/tyrian.min.css" rel="stylesheet" media="screen" />
      <link rel="icon" href="https://www.gentoo.org/favicon.ico" type="image/x-icon" />
    </head>
    <body>
      <header>
        <div class="site-title">
          <div class="container">
            <div class="row">
              <div class="site-title-buttons">
                <div class="btn-group btn-group-sm">
                  <a href="http://get.gentoo.org/" type="button" class="btn get-gentoo"><span class="fa fa-download"></span> <strong>Get Gentoo!</strong></a>
                  <div class="btn-group btn-group-sm">
                    <button type="button" class="gentoo-org-sites btn" data-toggle="dropdown">
                      <span class="glyphicon glyphicon-globe"></span> gentoo.org sites <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">
                      <li><a href="http://www.gentoo.org/" title="Main Gentoo website"><span class="fa fa-home fa-fw"></span> gentoo.org</a></li>
                      <li><a href="http://wiki.gentoo.org/" title="Find and contribute documentation"><span class="fa fa-file-text fa-fw"></span> Wiki</a></li>
                      <li><a href="https://bugs.gentoo.org/" title="Report issues and find common issues"><span class="fa fa-bug fa-fw"></span> Bugs</a></li>
                      <li><a href="http://forums.gentoo.org/" title="Discuss with the community"><span class="fa fa-comments-o fa-fw"></span> Forums</a></li>
                      <li><a href="http://packages.gentoo.org/" title="Find software for your Gentoo"><span class="fa fa-hdd-o fa-fw"></span> Packages</a></li>
                      <li class="divider"></li>
                      <li><a href="http://overlays.gentoo.org/" title="Collaborate on maintaining packages"><span class="fa fa-code-fork fa-fw"></span> Overlays</a></li>
                      <li><a href="http://planet.gentoo.org/" title="Find out what's going on in the developer community"><span class="fa fa-rss fa-fw"></span> Planet</a></li>
                      <li><a href="http://archives.gentoo.org/" title="Read up on past discussions"><span class="fa fa-archive fa-fw"></span> Archives</a></li>
                      <li><a href="http://sources.gentoo.org/" title="Browse our source code"><span class="fa fa-code fa-fw"></span> Sources</a></li>
                      <li class="divider"></li>
                      <li><a href="http://infra-status.gentoo.org/" title="Get updates on the services provided by Gentoo"><span class="fa fa-tasks fa-fw"></span> Infra Status</a></li>
                    </ul>
                  </div>
                </div>
              </div>
              <div class="logo">
                <img src="https://1b9a50f4f9de4348cd9f-e703bc50ba0aa66772a874f8c7698be7.ssl.cf5.rackcdn.com/site-logo.png" alt="Gentoo Linux Logo"/>
                <span class="site-label">Development Guide</span>
              </div>
            </div>
          </div>
        </div>

        <nav class="tyrian-navbar" role="navigation">
          <div class="container">
            <div class="row">
              <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-main-collapse">
                  <span class="sr-only">Toggle navigation</span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                </button>
              </div>
              <div class="collapse navbar-collapse navbar-main-collapse">
                <ul class="nav navbar-nav">
                  <li><a href="/index.html">Master Index</a></li>
                </ul>
              </div>
            </div>
          </div>
        </nav>

      </header>
      <div class="container">
        <div class="row">
          <div class="col-md-9">
            <xsl:if test="not(/guide/@root)">
              <xsl:call-template name="breadcrumbs"/>
            </xsl:if>
            <xsl:apply-templates/>
          </div>
          <div class="col-md-3">
            <xsl:call-template name="contentsTree">
              <xsl:with-param name="maxdepth" select="1"/>
            </xsl:call-template>
          </div>
        </div>
      </div>
      <footer>
        <div class="container">
          <div class="row">
            <div class="col-md-offset-8 col-md-4">
              <strong>Questions or comments?</strong><br/>
              Please feel free to <a href="mailto:infra@gentoo.org">contact us</a>.
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <strong>&#169; 2001-2014 Gentoo Foundation, Inc.</strong><br/>
              <small>
                Gentoo is a trademark of the Gentoo Foundation, Inc.
                The contents of this document, unless otherwise expressly stated, are licensed under the
                <a href="http://creativecommons.org/licenses/by-sa/3.0/" rel="license">CC-BY-SA-3.0</a> license.
                The <a href="#">Gentoo Name and Logo Usage Guidelines</a> apply.
              </small>
            </div>
          </div>
        </div>
      </footer>

      <script src="https://1b9a50f4f9de4348cd9f-e703bc50ba0aa66772a874f8c7698be7.ssl.cf5.rackcdn.com/jquery.min.js"></script>
      <script src="https://1b9a50f4f9de4348cd9f-e703bc50ba0aa66772a874f8c7698be7.ssl.cf5.rackcdn.com/bootstrap.min.js"></script>
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

  <xsl:template name="_link_breadcrumbs">
    <xsl:param name="depth" select="0"/>

    <xsl:param name="path_rel">
      <xsl:call-template name="str:repeatString">
        <xsl:with-param name="count" select="$depth"/>
        <xsl:with-param name="append">../</xsl:with-param>
      </xsl:call-template>
    </xsl:param>

    <xsl:if test="not(document(concat(/guide/@self, $path_rel, '/text.xml'))/guide/@root)">
      <xsl:call-template name="_link_breadcrumbs">
        <xsl:with-param name="depth" select="$depth + 1"/>
      </xsl:call-template>
    </xsl:if>

    <xsl:choose>
    <xsl:when test="$depth = 0">
      <li class="active"><xsl:value-of select="document(concat(/guide/@self, $path_rel, '/text.xml'))/guide/chapter[1]/title"/></li>
    </xsl:when>
    <xsl:otherwise>
      <li><a href="{concat($path_rel, 'index.html')}"><xsl:value-of select="document(concat(/guide/@self, $path_rel, '/text.xml'))/guide/chapter[1]/title"/></a></li>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="breadcrumbs">
    <ol class="breadcrumb">
      <xsl:call-template name="_link_breadcrumbs" />
    </ol>
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
