# Header.

bash$ [ -n $foo ] && [ -z $foo ] && echo "huh?"
huh?
bash$ [[ -n $foo ]] && [[ -z $foo ]] && echo "huh"?
bash$
