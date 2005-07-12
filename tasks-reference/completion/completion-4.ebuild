# Headers.

_revdep_rebuild() {
	local cur prev opts
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"
	opts="-X --package-names --soname --soname-regexp -q --quiet"

	if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] || \
	   [[ ${prev} == @(-q|--quiet) ]] ; then
		COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
		return 0
	fi
 
	case "${prev}" in
		-X|--package-names)
			_pkgname -I ${cur}
			;;
		--soname)
			local sonames=$(for x in /lib/*.so?(.)* /usr/lib*/*.so\?(.)* ; do \
						echo ${x##*/} ; \
						done)
			COMPREPLY=( $(compgen -W "${sonames}" -- ${cur}) )
			;;
		--soname-regexp)
			COMPREPLY=()
			;;
		*)
			if [[ ${COMP_LINE} == *" "@(-X|--package-names)* ]] ; then
				_pkgname -I ${cur}
				COMPREPLY=(${COMPREPLY[@]} $(compgen -W "${opts}"))
			else
				COMPREPLY=($(compgen -W "${opts} -- ${cur}"))
			fi
		;;
	esac
}
complete -F _revdep_rebuild revdep-rebuild
