# PATH
export PATH="$HOME/.bin:$HOME/bin:/usr/local/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_BUNDLE_FILE_GLOBAL="$HOME/.config/homebrew/Brewfile"

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
