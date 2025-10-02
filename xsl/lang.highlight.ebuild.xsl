<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:str="http://exslt.org/strings"
                xmlns:exslt="http://exslt.org/common"
                extension-element-prefixes="str exslt"
                exclude-result-prefixes="str exslt">

  <xsl:variable name="lang.highlight.ebuild.qvariable-start">$</xsl:variable>
  <xsl:variable name="lang.highlight.ebuild.variable-start">${</xsl:variable>
  <xsl:variable name="lang.highlight.ebuild.variable-end">}</xsl:variable>
  <xsl:variable name="lang.highlight.ebuild.commentChar">#</xsl:variable>

  <xsl:variable name="shell-keywords">
    ; if then fi -ge -lt -le -gt elif else eval unset sed rm cat [[ ]] while do read done make echo cd local return for
    case esac in -n [ ] -z -f &lt;&lt;- &gt; EOF
  </xsl:variable>

  <xsl:variable name="pkg-mgr-keywords">
    <!-- Package manager commands in EAPI 0 (excluding commands banned in later EAPIs) -->
    assert best_version debug-print debug-print-function debug-print-section die diropts dobin docinto doconfd dodir
    dodoc doenvd doexe doinfo doinitd doins dolib.a dolib.so doman domo dosbin dosym ebegin econf eend eerror einfo
    einfon elog emake ewarn exeinto exeopts EXPORT_FUNCTIONS fowners fperms has has_version inherit insinto insopts into
    keepdir newbin newconfd newdoc newenvd newexe newinitd newins newlib.a newlib.so newman newsbin unpack use usev
    use_enable use_with
    <!-- EAPI 4 -->
    docompress nonfatal
    <!-- EAPI 5 -->
    doheader newheader usex
    <!-- EAPI 6 -->
    eapply eapply_user einstalldocs get_libdir in_iuse
    <!-- EAPI 7 -->
    dostrip eqawarn ver_cut ver_rs ver_test
    <!-- EAPI 8: no new commands -->
    <!-- Sandbox -->
    adddeny addpredict addread addwrite
    <!-- Phase functions -->
    pkg_pretend pkg_setup pkg_preinst pkg_postinst pkg_prerm pkg_postrm pkg_config pkg_info pkg_nofetch src_unpack
    src_prepare src_configure src_compile src_test src_install
    <!-- Default phase functions -->
    default default_pkg_nofetch default_src_unpack default_src_prepare default_src_configure default_src_compile
    default_src_test default_src_install
  </xsl:variable>

  <xsl:variable name="eclass-keywords">
    <!-- autotools -->
    autotools_check_macro autotools_m4dir_include autotools_m4sysdir_include config_rpath_update eaclocal
    eaclocal_amflags eautoconf eautoheader eautomake eautopoint eautoreconf
    <!-- bash-completion-r1 -->
    bashcomp_alias dobashcomp get_bashcompdir newbashcomp
    <!-- cmake -->
    cmake_build cmake_comment_add_subdirectory cmake_run_in cmake_src_compile cmake_src_configure cmake_src_install
    cmake_src_prepare cmake_src_test cmake_use_find_package
    <!-- desktop -->
    doicon domenu make_desktop_entry make_session_desktop newicon newmenu
    <!-- flag-o-matic -->
    all-flag-vars append-atomic-flags append-cflags append-cppflags append-cxxflags append-fflags append-flags
    append-ldflags append-lfs-flags append-libs filter-flags filter-ldflags filter-lfs-flags filter-lto filter-mfpmath
    get-flag is-flag is-flagq is-ldflag is-ldflagq no-as-needed raw-ldflags replace-cpu-flags replace-flags
    replace-sparc64-flags strip-flags strip-unsupported-flags test-compile test-flag-CC test-flag-CCLD test-flag-CXX
    test-flag-F77 test-flag-FC test-flags test-flags-CC test-flags-CCLD test-flags-CXX test-flags-F77 test-flags-FC
    test_version_info
    <!-- git-r3 -->
    git-r3_checkout git-r3_fetch git-r3_peek_remote_ref git-r3_pkg_needrebuild git-r3_src_fetch git-r3_src_unpack
    pkg_needrebuild
    <!-- meson -->
    meson_feature meson_install meson_src_compile meson_src_configure meson_src_install meson_src_test meson_use
    <!-- multilib -->
    get_abi_CFLAGS get_abi_CHOST get_abi_CTARGET get_abi_FAKE_TARGETS get_abi_LDFLAGS get_abi_LIBDIR get_all_abis
    get_all_libdirs get_exeext get_install_abis get_libname get_modname has_multilib_profile is_final_abi multilib_env
    multilib_toolchain_setup number_abis
    <!-- ninja-utils -->
    eninja get_NINJAOPTS
    <!-- readme.gentoo-r1 -->
    readme.gentoo_create_doc readme.gentoo_print_elog
    <!-- rpm -->
    rpm_spec_epatch rpm_src_unpack rpm_unpack srcrpm_unpack
    <!-- toolchain-funcs -->
    clang-fullversion clang-major-version clang-micro-version clang-minor-version clang-version econf_build
    gcc-fullversion gcc-major-version gcc-micro-version gcc-minor-version gcc-specs-directive gcc-specs-nostrict
    gcc-specs-now gcc-specs-pie gcc-specs-relro gcc-specs-ssp gcc-specs-ssp-to-all gcc-specs-stack-check gcc-version
    gen_usr_ldscript tc-arch tc-arch-kernel tc-check-openmp tc-cpp-is-true tc-detect-is-softfloat
    tc-enables-cxx-assertions tc-enables-fortify-source tc-enables-pie tc-enables-ssp tc-enables-ssp-all
    tc-enables-ssp-strong tc-endian tc-env_build tc-export tc-export_build_env tc-get-c-rtlib tc-get-compiler-type
    tc-get-cxx-stdlib tc-getAR tc-getAS tc-getBUILD_AR tc-getBUILD_AS tc-getBUILD_CC tc-getBUILD_CPP tc-getBUILD_CXX
    tc-getBUILD_LD tc-getBUILD_NM tc-getBUILD_OBJCOPY tc-getBUILD_PKG_CONFIG tc-getBUILD_PROG tc-getBUILD_RANLIB
    tc-getBUILD_READELF tc-getBUILD_STRINGS tc-getBUILD_STRIP tc-getCC tc-getCPP tc-getCXX tc-getDLLWRAP tc-getF77
    tc-getFC tc-getGCJ tc-getGO tc-getLD tc-getNM tc-getOBJCOPY tc-getOBJDUMP tc-getPKG_CONFIG tc-getPROG tc-getRANLIB
    tc-getRC tc-getREADELF tc-getSTRINGS tc-getSTRIP tc-getTARGET_CPP tc-has-tls tc-is-clang tc-is-cross-compiler
    tc-is-gcc tc-is-softfloat tc-is-static-only tc-ld-disable-gold tc-ld-force-bfd tc-ld-is-gold tc-ld-is-lld
    tc-ninja_magic_to_arch tc-stack-grows-down tc-tuple-is-softfloat
    <!-- user -->
    enewgroup enewuser esetcomment esetgroups esethome esetshell
    <!-- virtualx -->
    virtx
    <!-- xdg -->
    xdg_pkg_postinst xdg_pkg_postrm xdg_pkg_preinst xdg_src_prepare
    <!-- xdg-utils -->
    xdg_desktop_database_update xdg_environment_reset xdg_icon_cache_update xdg_mimeinfo_database_update
  </xsl:variable>

  <xsl:template name="lang.highlight.ebuild.subtokenate">
    <xsl:param name="data"/>
    <xsl:param name="nokeywords"/>

    <xsl:choose>
      <!-- Tokenate variables in the form ${...} -->
      <xsl:when test="contains($data, '${')">
        <!-- Tokenate anything before it... -->
        <xsl:call-template name="lang.highlight.ebuild.subtokenate">
          <xsl:with-param name="data" select="substring-before($data, $lang.highlight.ebuild.variable-start)"/>
          <xsl:with-param name="nokeywords" select="$nokeywords"/>
        </xsl:call-template>
        <xsl:variable name="data-slack" select="substring-after($data, $lang.highlight.ebuild.variable-start)"/>
        <xsl:variable name="variable-name" select="substring-before($data-slack, $lang.highlight.ebuild.variable-end)"/>
        <span class="Identifier">${<xsl:value-of select="$variable-name"/>}</span>
        <xsl:call-template name="lang.highlight.ebuild.subtokenate">
          <xsl:with-param name="data" select="substring-after($data, $lang.highlight.ebuild.variable-end)"/>
          <xsl:with-param name="nokeywords" select="$nokeywords"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="contains($data, '$(')">
        <xsl:call-template name="lang.highlight.ebuild.subtokenate">
          <xsl:with-param name="data" select="substring-before($data, '$(')"/>
        </xsl:call-template>
        <span class="PreProc">$(</span>
        <xsl:call-template name="lang.highlight.ebuild.subtokenate">
          <xsl:with-param name="data" select="substring-after($data, '$(')"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="contains($data, '($(')">
        <xsl:call-template name="lang.highlight.ebuild.subtokenate">
          <xsl:with-param name="data" select="substring-before($data, '($(')"/>
        </xsl:call-template>
        <span class="PreProc">($(</span>
        <xsl:call-template name="lang.highlight.ebuild.subtokenate">
          <xsl:with-param name="data" select="substring-after($data, '($(')"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="substring($data, string-length($data)) = ')' and not(contains($data, '('))">
        <xsl:call-template name="lang.highlight.ebuild.subtokenate">
          <xsl:with-param name="data" select="substring($data, 1, string-length($data)-1)"/>
        </xsl:call-template>
        <span class="PreProc">)</span>
      </xsl:when>

      <xsl:when test="substring($data, 1, 1) = $lang.highlight.ebuild.qvariable-start">
        <span class="Identifier">$<xsl:value-of select="substring($data, 2)"/></span>
      </xsl:when>

      <xsl:when test="substring($data, 1, 1) = '(' and not(contains($data, ')'))">
        <span class="PreProc">(</span>
        <xsl:call-template name="lang.highlight.ebuild.subtokenate">
          <xsl:with-param name="data" select="substring($data, 2, string-length($data))"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="$nokeywords = 'True'">
        <xsl:value-of select="$data"/>
      </xsl:when>

      <!-- Args -->
      <xsl:when test="contains($data, '--')">
        <xsl:call-template name="lang.highlight.ebuild.subtokenate">
          <xsl:with-param name="data" select="substring-before($data, '--')"/>
        </xsl:call-template>
        <span class="PreProc">--</span>
        <xsl:variable name="cdata" select="substring-after($data, '--')"/>
        <xsl:choose>
          <xsl:when test="contains($data, ')')">
            <span class="Comment">
              <xsl:call-template name="lang.highlight.ebuild.subtokenate">
                <xsl:with-param name="data" select="substring-before(substring-after($data, '--'), ')')"/>
              </xsl:call-template>
            </span>)<xsl:value-of select="substring-after(substring-after($data, '--'), ')')"/>
          </xsl:when>
          <xsl:otherwise>
            <span class="Comment">
              <xsl:call-template name="lang.highlight.ebuild.subtokenate">
                <xsl:with-param name="data" select="substring-after($data, '--')"/>
              </xsl:call-template>
            </span>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

      <!-- Function highlighting -->
      <!-- sh grammar -->
      <xsl:when test="str:tokenize($shell-keywords)[$data = .]">
        <span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!-- Package manager commands -->
      <xsl:when test="str:tokenize($pkg-mgr-keywords)[$data = .]">
        <span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!-- Eclass commands -->
      <xsl:when test="str:tokenize($eclass-keywords)[$data = .]">
        <span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!-- No match return -->
      <xsl:otherwise>
        <xsl:value-of select="$data"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="lang.highlight.ebuild.tokenate">
    <xsl:param name="data"/>

    <!-- Only tokenize spaces, this way we preserve tabs. -->
    <xsl:variable name="tokenizedData" select="str:tokenize_plasmaroo($data, '&quot; &#9;')"/>

    <!-- Scan for comments. If a comment is found then this is a positional
         index that is non-zero that refers to the last node that is not
         a comment. -->
    <xsl:variable name="commentSeeker" select="count(str:tokenize_plasmaroo(substring-before($data,
                                               concat(' ', $lang.highlight.ebuild.commentChar))))"/>

    <!-- Scan for quotes... -->
    <xsl:for-each select="exslt:node-set($tokenizedData)">
    <xsl:variable name="myPos" select="position()"/>
    <xsl:variable name="quotePos" select="count(../*[@delimiter='&quot;' and position() &lt; $myPos])"/>

    <xsl:choose>
      <!-- See if we should be processing comments by now; we need to test for
           two possible cases:  * commentSeeker != 0 (so we have a comment), or,
                                * the first token is a "#" -->
      <xsl:when test="($commentSeeker != 0 and position() &gt; $commentSeeker) or
                      substring(../*[position()=1], 1, 1) = $lang.highlight.ebuild.commentChar or
                      . = $lang.highlight.ebuild.commentChar">
        <span class="Comment"><xsl:value-of select="."/></span>
      </xsl:when>

      <!-- Highlight a quote -->
      <xsl:when test=". = '&quot;'">
        <span class="Statement">&quot;</span>
      </xsl:when>

      <!-- If we're inside quotes stop here -->
      <xsl:when test="$quotePos mod 2 != 0">
        <xsl:call-template name="lang.highlight.ebuild.subtokenate">
          <xsl:with-param name="data"><xsl:value-of select="."/></xsl:with-param>
          <xsl:with-param name="nokeywords">True</xsl:with-param>
        </xsl:call-template>
      </xsl:when>

      <!-- Highlight functions;
           @token_regexp = [^\w]+()
           @pos = 1 -->
      <xsl:when test="position() = 1 and substring(., string-length(.)-1) = '()'">
        <span class="Special"><xsl:value-of select="."/></span>
      </xsl:when>

      <!-- Highlight variable assignments;
           @regexp = [\w]=["']{...}['"] -->
      <xsl:when test="contains(., '=')">
        <span class="Identifier"><xsl:value-of select="substring-before(., '=')"/></span>
        <span class="Constant">=</span>
        <xsl:call-template name="lang.highlight.ebuild.subtokenate">
          <xsl:with-param name="data" select="substring-after(., '=')"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test=". = '{' or . = '}' or . = '\' or . = '('">
        <span class="PreProc"><xsl:value-of select="."/></span>
      </xsl:when>

      <xsl:when test=". = '||' or . = '&amp;&amp;' or . = '|'">
        <span class="Statement"><xsl:value-of select="."/></span>
      </xsl:when>

      <!-- No match return -->
      <xsl:otherwise>
        <xsl:call-template name="lang.highlight.ebuild.subtokenate">
          <xsl:with-param name="data" select="."/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>

<!-- Local Variables: -->
<!-- indent-tabs-mode: nil -->
<!-- fill-column: 120 -->
<!-- End: -->
