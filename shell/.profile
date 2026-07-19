# PATH
export PATH="$HOME/.bin:$HOME/bin:$PATH"

# Homebrew (Apple Silicon or Intel prefix). The ONLY Node.js on the system
# comes from here — see "Node.js policy" in the README.
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [ -x "$_brew" ]; then
        eval "$("$_brew" shellenv)"
        break
    fi
done
unset _brew
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_BUNDLE_FILE_GLOBAL="$HOME/.config/homebrew/Brewfile"

# Prefer gsed over sed
[ -d "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" ] && export PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"

# TeX Live — MacTeX's version-independent symlink, survives yearly upgrades
[ -d /Library/TeX/texbin ] && export PATH="/Library/TeX/texbin:$PATH"

# pipx and other user-installed tools (claude lives here)
export PATH="$HOME/.local/bin:$PATH"

# Obsidian CLI
[ -d "/Applications/Obsidian.app/Contents/MacOS" ] && export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

# Environment
export EDITOR='nvim'
export XDG_CONFIG_HOME="$HOME/.config"
export LC_CTYPE="fi_FI.UTF-8"
export MERMAID_BIN="$HOMEBREW_PREFIX/bin/mmdc"
