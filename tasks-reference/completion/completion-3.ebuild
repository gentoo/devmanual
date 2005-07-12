# Headers.

case "${prev}" in
	-f|--file)
		COMPREPLY=( $(compgen -f ? ${cur}) )
		;;
esac