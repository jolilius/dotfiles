# PATH
export PATH=$HOME/.bin:$HOME/bin:/usr/local/bin:$PATH
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1

# Prefer gsed over sed
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# texlive
export PATH="/usr/local/texlive/2022/bin/universal-darwin:$PATH"
export MANPATH="/usr/local/texlive/2022/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2022/texmf-dist/doc/info:$INFOPATH"

# Environment
export EDITOR='nvim'
export XDG_CONFIG_HOME="$HOME/.config"
export LC_CTYPE="fi_FI.UTF-8"
export MERMAID_BIN='/usr/local/bin/mmdc'

# Plugins (via Homebrew)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Bind up/down arrows to history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Vi mode
bindkey -v

# Aliases
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "WIP"'

# eza (modern ls)
alias ls='eza --icons=auto'
alias l='eza -l --icons=auto'
alias ll='eza -l --git --icons=auto'
alias la='eza -la --git --icons=auto'
alias lt='eza --tree --icons=auto'
alias llt='eza -la --tree --git --icons=auto'

# zoxide (z command for directory jumping)
eval "$(zoxide init zsh)"

# Prompt
eval "$(starship init zsh)"
