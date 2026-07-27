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
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Alias
alias xsync="sudo xbps-sync"
alias xinstall="sudo xbps-install"
alias xremove="sudo xbps-remove"
alias xquery="xbps-query"
alias xsearch="xbps-query -Rs"

compdef xbps-sync=xbps-install
