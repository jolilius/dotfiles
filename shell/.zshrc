source ~/.profile

# Plugins (via Homebrew)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Vi mode
bindkey -v

# History navigation (must come after bindkey -v)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# Keep Brewfile in sync after install/uninstall/tap changes
brew() {
  command brew "$@"
  local ret=$?
  if [[ $ret -eq 0 ]]; then
    case "$1" in
      install|uninstall|rm|remove|reinstall|tap|untap)
        command brew bundle dump --global --force --quiet
        ;;
    esac
  fi
  return $ret
}

# Aliases
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "WIP"'

# less / bat
alias m='less'
alias cat='bat --paging=never'
alias b='bat'

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
