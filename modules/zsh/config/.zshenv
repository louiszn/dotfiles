export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

typeset -U path PATH
path=("$XDG_BIN_HOME" $path)
