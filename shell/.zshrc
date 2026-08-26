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

# Open Interpreter against self-hosted vLLM (Qwen2.5-Coder-32B on mandelbrot.abo.fi).
# `interpreter -p vllm` doesn't work — this build ignores model_providers/profiles
# defined in config.toml, so the provider has to be passed via -c flags each run.
interpreter-vllm() {
  interpreter \
    -c 'model_providers.vllm.name="vLLM (mandelbrot)"' \
    -c 'model_providers.vllm.base_url="http://100.89.90.6:8000/v1"' \
    -c 'model_providers.vllm.env_key="VLLM_API_KEY"' \
    -c 'model_providers.vllm.wire_api="responses"' \
    -c model_provider="vllm" -c model="qwen-coder-32b" \
    -c model_context_window=32000 \
    "$@"
}

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

# ripgrep (modern grep)
alias grep='rg'

# fd (modern find)
alias find='fd'

# zoxide (z command for directory jumping)
eval "$(zoxide init zsh)"

# Prompt
eval "$(starship init zsh)"
