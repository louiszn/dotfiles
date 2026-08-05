fpath+=(/usr/share/zsh/site-functions)

autoload -Uz compinit && compinit
autoload -Uz colors && colors

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt prompt_subst

PROMPT='%F{blue}%~%f %F{magenta$%f '

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# Plugins
plugins_dir=/usr/share/zsh/plugins

[[ -f "$plugins_dir/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && 
	source "$plugins_dir/zsh-autosuggestions/zsh-autosuggestions.zsh"

[[ -f "$plugins_dir/zsh-history-substring-search/zsh-history-substring-search.zsh" ]] &&
	source "$plugins_dir/zsh-history-substring-search/zsh-history-substring-search.zsh"

[[ -f "$plugins_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] &&
	source "$plugins_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Alias
alias xsync="sudo xbps-sync"
alias xinstall="sudo xbps-install"
alias xremove="sudo xbps-remove"
alias xquery="xbps-query"
alias xsearch="xbps-query -Rs"

compdef xbps-sync=xbps-install
