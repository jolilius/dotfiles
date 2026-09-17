#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$DOTFILES_DIR/homebrew/.config/homebrew/Brewfile"

# Machine-local secrets (gitignored) — needed below for MCP server API keys.
# See shell/.config/local.env.example.
[ -f "$HOME/.config/local.env" ] && source "$HOME/.config/local.env"

if command -v brew >/dev/null 2>&1; then
  echo "🍺 Installing Homebrew dependencies..."
  # ekctl's formula builds from source and depends_on the full Xcode app
  # (not just the Command Line Tools), so skip it unless Xcode is installed.
  if [[ ! -d "/Applications/Xcode.app" ]]; then
    export HOMEBREW_BUNDLE_BREW_SKIP="schappim/ekctl/ekctl"
    echo "  ⚠️  Skipping ekctl: requires the full Xcode app (not just Command Line Tools)."
    echo "     Install Xcode from the App Store, then run: brew bundle install --file=\"$BREWFILE\""
  fi
  brew bundle install --file="$BREWFILE"
fi

if ! command -v qmd >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
  echo "📦 Installing qmd (https://github.com/tobi/qmd)..."
  npm install -g @tobilu/qmd
fi

echo "🤖 Installing Claude skills..."

# QMD skill (bundled with the qmd CLI)
if command -v qmd >/dev/null 2>&1 && [[ ! -e "$HOME/.agents/skills/qmd" ]]; then
  qmd skill install --global --yes
fi

# GSD (workflow framework): installs/updates its own hooks, agents, and
# settings under ~/.claude — this is a generated-state directory, not
# something to stow, so re-run its own installer on each machine instead.
if command -v npx >/dev/null 2>&1; then
  npx -y --package=@opengsd/gsd-core@latest -- gsd-core --claude --global
fi

# Claude plugin marketplaces
if command -v claude >/dev/null 2>&1; then
  claude plugin marketplace add schappim/ekctl-skill
  claude plugin install ekctl-skill@ekctl-skill

  claude plugin marketplace add kepano/obsidian-skills
  claude plugin install obsidian@obsidian-skills

  claude plugin marketplace add mvanhorn/last30days-skill
  claude plugin install last30days@last30days-skill
fi

echo "🔌 Configuring Claude MCP servers (user scope)..."
# Declarative source of truth for MCP servers, since ~/.claude.json is live
# app state (machine IDs, caches, project paths) and unsafe to symlink.
# `claude mcp get` exits 1 if missing, so these are safe to re-run.
if command -v claude >/dev/null 2>&1; then
  claude mcp get arxiv >/dev/null 2>&1 || claude mcp add arxiv -s user -- uvx arxiv-mcp-server

  if [[ -n "$BRAVE_API_KEY" ]]; then
    claude mcp get brave-search >/dev/null 2>&1 || claude mcp add brave-search -s user -e BRAVE_API_KEY="$BRAVE_API_KEY" -- npx -y @brave/brave-search-mcp-server
  else
    echo "  ⚠️  BRAVE_API_KEY not set (see ~/.config/local.env.example) — skipping brave-search"
  fi

  if [[ -n "$SEMANTIC_SCHOLAR_API_KEY" ]]; then
    claude mcp get semantic-scholar >/dev/null 2>&1 || claude mcp add semantic-scholar -s user -e SEMANTIC_SCHOLAR_API_KEY="$SEMANTIC_SCHOLAR_API_KEY" -- uvx --from git+https://github.com/akapet00/semantic-scholar-mcp semantic-scholar-mcp
  else
    echo "  ⚠️  SEMANTIC_SCHOLAR_API_KEY not set (see ~/.config/local.env.example) — skipping semantic-scholar"
  fi
fi

echo "🪝 Enabling auto-push git hook for this repo..."
git -C "$DOTFILES_DIR" config core.hooksPath .githooks

echo "🧹 Preflight: backing up plain-file dotfiles that would block stow..."
# A pre-existing regular file (not a symlink) at a target path makes stow skip
# it silently — the repo config then never takes effect for that file.
for f in .profile .zprofile .zshenv .zshrc .bashrc .bash_profile; do
    if [[ -e "$HOME/$f" && ! -L "$HOME/$f" ]]; then
        mv "$HOME/$f" "$HOME/$f.pre-stow.bak"
        echo "  ⚠️  ~/$f was a plain file — moved to ~/$f.pre-stow.bak (review, then delete)"
    fi
done

# BasicTeX/MacTeX's installer .pkg leaves the TeX Live tree root-owned, so
# every `tlmgr install <pkg>` needs sudo until this is fixed once per machine.
for texlive_dir in /usr/local/texlive/*basic; do
    if [[ -d "$texlive_dir" ]] && [[ "$(stat -f%Su "$texlive_dir" 2>/dev/null)" != "$(whoami)" ]]; then
        echo "🔧 Fixing TeX Live ownership so tlmgr doesn't need sudo: $texlive_dir"
        sudo chown -R "$(whoami)" "$texlive_dir"
    fi
done

# Packages beyond BasicTeX's default scheme, needed by beamer decks and
# LaTeX templates in Teaching/*. tlmgr install is idempotent (skips packages
# already at the current version), so safe to rerun on every machine.
if command -v tlmgr >/dev/null 2>&1; then
  echo "📄 Installing extra TeX Live packages..."
  TEX_PACKAGES=(beamer moloch bytefield lastpage titlesec ragged2e pgfpages)
  tlmgr install "${TEX_PACKAGES[@]}"
fi

# A Node from the nodejs.org pkg installer shadows Homebrew's node in some
# shell contexts and causes native-module ABI mismatches (see README,
# "Node.js policy"). On Intel Macs /usr/local/bin/node IS Homebrew's (a
# symlink), so only a real file counts.
if [[ -x /usr/local/bin/node && ! -L /usr/local/bin/node ]]; then
    echo "⚠️  Non-Homebrew Node.js found at /usr/local/bin/node — remove it with:"
    echo "      sudo rm -f /usr/local/bin/node /usr/local/bin/npm /usr/local/bin/npx /usr/local/bin/corepack"
    echo "      sudo rm -rf /usr/local/lib/node_modules /usr/local/include/node"
    echo "      sudo pkgutil --forget org.nodejs.node.pkg 2>/dev/null || true"
fi

echo "🔗 Installing dotfiles with stow..."

# Always pass both -d and -t explicitly. Without -t, stow's target defaults
# to the parent directory of the stow dir (-d), not $HOME — if this repo
# isn't cloned directly into $HOME, that silently symlinks into the wrong
# place (e.g. ~/src/.config instead of ~/.config) rather than erroring.
# Core packages (cross-platform)
stow -d "$DOTFILES_DIR" -t ~ shell
stow -d "$DOTFILES_DIR" -t ~ editor
stow -d "$DOTFILES_DIR" -t ~ git
stow -d "$DOTFILES_DIR" -t ~ tools
stow -d "$DOTFILES_DIR" -t ~ terminal
stow -d "$DOTFILES_DIR" -t ~ bin
stow -d "$DOTFILES_DIR" -t ~ homebrew

# Platform-specific
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "🍎 macOS detected"
  stow -d "$DOTFILES_DIR" -t ~ launchd
  echo "  Loading QMD LaunchAgents..."
  for label in com.qmd.update com.qmd.refresh; do
    launchctl bootout "gui/$(id -u)/$label" 2>/dev/null || true
    launchctl bootstrap "gui/$(id -u)" "$HOME/Library/LaunchAgents/$label.plist"
  done
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "🐧 Linux detected"
  # Add Linux-specific packages here if needed
fi

echo "✅ Dotfiles installed!"
echo ""
echo "📝 Next steps:"
echo "  - Review symlinks: ls -la ~"
echo "  - Verify configurations loaded in new shell"
echo "  - Customize as needed"
