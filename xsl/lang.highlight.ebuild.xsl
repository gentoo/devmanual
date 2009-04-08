<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
  xmlns:str="http://exslt.org/strings"
  xmlns:exslt="http://exslt.org/common"
  extension-element-prefixes="str exslt xsl"
  exclude-result-prefixes="str exslt xsl"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:variable name="lang.highlight.ebuild.qvariable-start">$</xsl:variable>
  <xsl:variable name="lang.highlight.ebuild.variable-start">${</xsl:variable>
  <xsl:variable name="lang.highlight.ebuild.variable-end">}</xsl:variable>
  <xsl:variable name="lang.highlight.ebuild.commentChar">#</xsl:variable>

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

      <!-- Functioney highlighing -->
      <!-- sh grammar -->
      <xsl:when test="$data = ';' or $data = 'if' or $data = 'then' or $data = 'fi' or $data = '-ge' or $data = '-lt' or $data = '-le' or
                      $data = '-gt' or $data = 'elif' or $data = 'else' or $data = 'eval' or $data = 'unset' or $data = 'sed' or
                      $data = 'rm' or $data = 'cat' or $data = '[[' or $data = ']]' or $data = 'while' or $data = 'do' or $data = 'read' or
                      $data = 'done' or $data = 'make' or $data = 'echo' or $data = 'cd' or $data = 'local' or $data = 'return' or
                      $data = 'for' or $data = 'case' or $data = 'esac' or $data = 'in' or $data = '-n' or $data = '[' or $data = ']' or
                      $data = '-z' or $data = '-f' or $data = '&lt;&lt;-' or $data = '&gt;' or $data = 'EOF'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!-- Default keywords -->
      <xsl:when test="$data = 'use' or $data = 'has_version' or $data = 'best_version' or $data = 'use_with' or $data = 'use_enable' or
		      $data = 'check_KV' or $data = 'keepdir' or $data = 'econf' or $data = 'die' or $data = 'einstall' or $data = 'einfo' or 
		      $data = 'elog' or
		      $data = 'ewarn' or $data = 'eerror' or $data = 'diropts' or $data = 'dobin' or $data = 'docinto' or $data = 'dodoc' or
		      $data = 'doexe' or $data = 'dohard' or $data = 'dohtml' or $data = 'doinfo' or $data = 'doins' or $data = 'dolib' or
		      $data = 'dolib$dataa' or $data = 'dolib$dataso' or $data = 'doman' or $data = 'dosbin' or $data = 'dosym' or $data = 'emake' or
		      $data = 'exeinto' or $data = 'exeopts' or $data = 'fowners' or $data = 'fperms' or $data = 'insinto' or $data = 'insopts' or
		      $data = 'into' or $data = 'libopts' or $data = 'newbin' or $data = 'newexe' or $data = 'newins' or $data = 'newman' or
		      $data = 'newsbin' or $data = 'prepall' or $data = 'prepalldocs' or $data = 'prepallinfo' or $data = 'prepallman' or
		      $data = 'prepallstrip' or $data = 'has' or $data = 'unpack' or $data = 'dosed' or $data = 'into' or
		      $data = 'doinitd' or $data = 'doconfd' or $data = 'doenvd' or $data = 'dojar' or $data = 'domo' or $data = 'dodir' or
		      $data = 'ebegin' or $data = 'eend' or $data = 'newconfd' or $data = 'newdoc' or $data = 'newenvd' or $data = 'newinitd' or
		      $data = 'newlib.a' or $data = 'newlib.so' or $data = 'hasq' or $data = 'hasv' or $data = 'useq' or $data = 'usev'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!-- Sandbox -->
      <xsl:when test="$data = 'addread' or $data = 'addwrite' or $data = 'adddeny' or $data = 'addpredict'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!-- Recognised functions -->
      <xsl:when test="$data = 'pkg_nofetch' or $data = 'pkg_setup' or $data = 'src_unpack' or $data = 'src_compile' or $data = 'src_test' or
		      $data = 'src_install' or $data = 'pkg_preinst' or $data = 'pkg_postinst' or $data = 'pkg_prerm' or $data = 'pkg_postrm' or
		      $data = 'pkg_config'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!-- Inherit -->
      <xsl:when test="$data = 'inherit'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!-- eutils -->
      <xsl:when test="$data = 'gen_usr_ldscript' or $data = 'draw_line' or $data = 'epatch' or $data = 'have_NPTL' or $data = 'get_number_of_jobs' or
		      $data = 'egetent' or $data = 'emktemp' or $data = 'enewuser' or $data = 'enewgroup' or $data = 'edos2unix' or
		      $data = 'make_desktop_entry' or $data = 'unpack_pdv' or $data = 'unpack_makeself' or $data = 'check_license' or
		      $data = 'cdrom_get_cds' or $data = 'cdrom_load_next' or $data = 'cdrom_locate_file_on_cd' or $data = 'strip-linguas' or
		      $data = 'epause' or $data = 'ebeep' or $data = 'built_with_use' or $data = 'make_session_desktop' or $data = 'domenu' or
		      $data = 'doicon' or $data = 'find_unpackable_file' or $data = 'unpack_pdv' or $data = 'set_arch_to_kernel' or
		      $data = 'set_arch_to_portage' or $data = 'preserve_old_lib' or $data = 'preserve_old_lib_notify' or $data = 'built_with_use' or
		      $data = 'epunt_cxx' or $data = 'dopamd' or $data = 'newpamd' or $data = 'make_wrapper'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!-- flag-o-matic -->
      <xsl:when test="$data = 'setup-allowed-flags' or $data = 'filter-flags' or $data = 'filter-lfs-flags' or $data = 'append-lfs-flags' or
		      $data = 'append-flags' or $data = 'replace-flags' or $data = 'replace-cpu-flags' or $data = 'is-flag' or $data = 'filter-mfpmath' or
		      $data = 'strip-flags' or $data = 'test_flag' or $data = 'test_version_info' or $data = 'strip-unsupported-flags' or
		      $data = 'get-flag' or $data = 'has_hardened' or $data = 'has_pic' or $data = 'has_pie' or $data = 'has_ssp_all' or $data = 'has_ssp' or
		      $data = 'has_m64' or $data = 'has_m32' or $data = 'replace-sparc64-flags' or $data = 'append-ldflags' or $data = 'filter-ldflags' or
		      $data = 'fstack-flags' or $data = 'gcc2-flags'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  gcc -->
      <xsl:when test="$data = 'gcc-getCC' or $data = 'gcc-getCXX' or $data = 'gcc-fullversion' or $data = 'gcc-version' or
		      $data = 'gcc-major-version' or $data = 'gcc-minor-version' or $data = 'gcc-micro-version' or
		      $data = 'gcc-libpath' or $data = 'gcc-libstdcxx-version' or $data = 'gcc-libstdcxx-major-version' or
		      $data = 'gcc2-flags'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  libtool -->
      <xsl:when test="$data = 'elibtoolize' or $data = 'uclibctoolize' or $data = 'darwintoolize'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  fixheadtails -->
      <xsl:when test="$data = 'ht_fix_file' or $data = 'ht_fix_all'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  fdo-mime -->
      <xsl:when test="$data = 'fdo-mime_desktop_database_update' or $data = 'fdo-mime_mime_database_update'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  webapp -->
      <xsl:when test="$data = 'webapp_checkfileexists' or $data = 'webapp_import_config' or $data = 'webapp_strip_appdir' or
		      $data = 'webapp_strip_d' or $data = 'webapp_strip_cwd' or $data = 'webapp_configfile' or $data = 'webapp_hook_script' or
		      $data = 'webapp_postinst_txt' or $data = 'webapp_postupgrade_txt' or $data = 'webapp_runbycgibin' or
		      $data = 'webapp_serverowned' or $data = 'webapp_server_configfile' or $data = 'webapp_sqlscript' or
		      $data = 'webapp_src_install' or $data = 'webapp_pkg_postinst' or $data = 'webapp_pkg_setup' or
		      $data = 'webapp_getinstalltype' or $data = 'webapp_src_preinst' or $data = 'webapp_pkg_prerm'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!-- versionator -->
      <xsl:when test="$data = 'get_all_version_components' or $data = 'version_is_at_least' or $data = 'get_version_components' or
		      $data = 'get_major_version' or $data = 'get_version_component_range' or $data = 'get_after_major_version' or
		      $data = 'replace_version_separator' or $data = 'replace_all_version_separators' or $data = 'delete_version_separator' or
		      $data = 'delete_all_version_separators'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  cvs -->
      <xsl:when test="$data = 'cvs_fetch' or $data = 'cvs_src_unpack'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  bash-completion -->
      <xsl:when test="$data = 'dobashcompletion' or $data = 'bash-completion_pkg_postinst' or $data = 'complete'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  vim-plugin -->
      <xsl:when test="$data = 'vim-plugin_src_install' or $data = 'vim-plugin_pkg_postinst' or $data = 'vim-plugin_pkg_postrm' or
		      $data = 'update_vim_afterscripts' or $data = 'display_vim_plugin_help'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  vim-doc -->
      <xsl:when test="update_vim_helptags">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  multilib -->
      <xsl:when test="$data = 'has_multilib_profile' or $data = 'get_libdir' or $data = 'get_multilibdir' or $data = 'get_libdir_override' or
		      $data = 'get_abi_var' or $data = 'get_abi_CFLAGS' or $data = 'get_abi_LDFLAGS' or
		      $data = 'get_abi_CHOST' or $data = 'get_abi_FAKE_TARGETS' or $data = 'get_abi_CDEFINE' or
		      $data = 'get_abi_LIBDIR' or $data = 'get_install_abis ' or $data = 'get_all_abis' or $data = 'get_all_libdirs' or
		      $data = 'is_final_abi' or $data = 'number_abis' or $data = 'get_ml_incdir' or $data = 'prep_ml_includes' or
		      $data = 'create_ml_includes' or $data = 'create_ml_includes-absolute' or $data = 'create_ml_includes-tidy_path' or
		      $data = 'create_ml_includes-listdirs' or $data = 'create_ml_includes-makedestdirs' or $data = 'create_ml_includes-allfiles' or
		      $data = 'create_ml_includes-sym_for_dir'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  toolchain-funcs -->
      <xsl:when test="$data = 'tc-getPROG' or $data = 'tc-getAR' or $data = 'tc-getAS' or $data = 'tc-getCC' or $data = 'tc-getCXX' or $data = 'tc-getLD' or $data = 'tc-getNM' or
		      $data = 'tc-getRANLIB' or $data = 'tc-getF77' or $data = 'tc-getGCJ' or $data = 'tc-getBUILD_CC' or
		      $data = 'tc-export' or $data = 'ninj' or $data = 'tc-is-cross-compiler' or $data = 'tc-ninja_magic_to_arch' or
		      $data = 'tc-arch-kernel' or $data = 'tc-arch' or $data = 'tc-endian' or $data = 'gcc-fullversion' or
		      $data = 'gcc-version' or $data = 'gcc-major-version' or $data = 'gcc-minor-version' or $data = 'gcc-micro-version'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  cron -->
      <xsl:when test="$data = 'docrondir' or $data = 'docron' or $data = 'docrontab' or $data = 'cron_pkg_postinst'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  games -->
      <xsl:when test="$data = 'egamesconf' or $data = 'egamesinstall' or $data = 'gameswrapper' or $data = 'dogamesbin' or $data = 'dogamessbin' or $data = 'dogameslib' or
		      $data = 'dogameslib$dataa' or $data = 'dogameslib$dataso' or $data = 'newgamesbin' or $data = 'newgamessbin' or
		      $data = 'gamesowners' or $data = 'gamesperms' or $data = 'prepgamesdirs' or $data = 'gamesenv' or $data = 'games_pkg_setup' or
		      $data = 'games_src_compile' or $data = 'games_pkg_postinst' or $data = 'games_ut_unpack' or $data = 'games_umod_unpack' or
		      $data = 'games_make_wrapper'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  subversion -->
      <xsl:when test="$data = 'subversion_svn_fetch' or $data = 'subversion_bootstrap' or $data = 'subversion_src_unpack'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  alternatives -->
      <xsl:when test="$data = 'alternatives_auto_makesym' or $data = 'alternatives_makesym' or $data = 'alternatives_pkg_postinst' or
		      $data = 'alternatives_pkg_postrm'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  rpm -->
      <xsl:when test="$data = 'rpm_unpack' or $data = 'rpm_src_unpack'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  python -->
      <xsl:when test="$data = 'python_version' or $data = 'python_tkinter_exists' or $data = 'python_mod_exists' or $data = 'python_mod_compile' or
		      $data = 'python_mod_optimize' or $data = 'python_mod_cleanup' or $data = 'python_makesym' or $data = 'python_disable_pyc' or
		      $data = 'python_enable_pyc'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  check-kernel -->
      <xsl:when test="$data = 'check_version_h' or $data = 'get_KV_info' or $data = 'is_2_4_kernel' or $data = 'is_2_5_kernel' or $data = 'is_2_6_kernel' or
		      $data = 'kernel_supports_modules'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  perl-module -->
      <xsl:when test="$data = 'perl-module_src_prep' or $data = 'perl-module_src_compile' or $data = 'perl-module_src_test' or
		      $data = 'perl-module_src_install' or $data = 'perl-module_pkg_setup' or $data = 'perl-module_pkg_preinst' or
		      $data = 'perl-module_pkg_postinst' or $data = 'perl-module_pkg_prerm' or $data = 'perl-module_pkg_postrm' or
		      $data = 'perlinfo' or $data = 'fixlocalpod' or $data = 'updatepod'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  distutils -->
      <xsl:when test="$data = 'distutils_src_compile' or $data = 'distutils_src_install' or $data = 'distutils_pkg_postrm' or
		      $data = 'distutils_pkg_postinst' or $data = 'distutils_python_version' or $data = 'disutils_python_tkinter'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  depend$dataapache -->
      <xsl:when test="$data = 'need_apache' or $data = 'need_apache1' or $data = 'need_apache2'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  apache-module -->
      <xsl:when test="$data = 'apache-module_pkg_setup' or $data = 'apache-module_src_compile' or
		      $data = 'apache-module_src_install' or $data = 'apache-module_pkg_postinst' or $data = 'acache_cd_dir' or
		      $data = 'apache_mod_file' or $data = 'apache_doc_magic' or $data = 'apache1_src_compile' or $data = 'apache1_src_install' or
		      $data = 'apache1_pkg_postinst' or $data = 'apache2_pkg_setup' or $data = 'apache2_src_compile' or
		      $data = 'apache1_src_install' or $data = 'apache2_pkg_postinst'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  pam -->
      <xsl:when test="$data = 'dopamd' or $data = 'newpamd' or $data = 'dopamsecurity' or $data = 'newpamsecurity' or $data = 'getpam_mod_dir' or
		      $data = 'dopammod' or $data = 'newpammod' or $data = 'pamd_mimic_system'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  virtualx -->
      <xsl:when test="$data = 'virtualmake' or $data = 'Xmake' or $data = 'Xemake' or $data = 'Xeconf'">
	<span class="Statement"><xsl:value-of select="$data"/></span>
      </xsl:when>

      <!--  gnome2 -->
      <xsl:when test="$data = 'gnome2_src_configure' or $data = 'gnome2_src_compile' or $data = 'gnome2_src_install' or
		      $data = 'gnome2_gconf_install' or $data = 'gnome2_gconf_uninstal' or $data = 'gnome2_omf_fix' or
		      $data = 'gnome2_scrollkeeper_update' or $data = 'gnome2_pkg_postinst' or $data = 'gnome2_pkg_postrm'">
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
    <xsl:variable name="commentSeeker" select="count(str:tokenize_plasmaroo(substring-before($data, concat(' ', $lang.highlight.ebuild.commentChar))))"/>

    <!-- Scan for quotes... -->
    <xsl:for-each select="exslt:node-set($tokenizedData)">
    <xsl:variable name="myPos" select="position()"/>
    <xsl:variable name="quotePos" select="count(../*[@delimiter='&quot;' and position() &lt; $myPos])"/>
    
    <xsl:choose>
      <!-- See if we should be processing comments by now; we need to test for
	   two possible cases:	* commentSeeker != 0 (so we have a comment), or,
				* the first token is a "#" -->
      <xsl:when test="($commentSeeker != 0 and position() > $commentSeeker) or substring(../*[position()=1], 1, 1) = $lang.highlight.ebuild.commentChar or
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
