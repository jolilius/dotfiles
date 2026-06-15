#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if command -v brew >/dev/null 2>&1; then
    echo "🍺 Installing Homebrew dependencies..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
fi

if ! command -v qmd >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
    echo "📦 Installing qmd (https://github.com/tobi/qmd)..."
    npm install -g @tobilu/qmd
fi

# ekctl (Calendar/Reminders CLI) - its Homebrew formula builds from source and
# requires the full Xcode app (not just the Command Line Tools), so it can't be
# installed unattended via the Brewfile.
if command -v brew >/dev/null 2>&1 && ! command -v ekctl >/dev/null 2>&1; then
    if [[ -d "/Applications/Xcode.app" ]]; then
        echo "📅 Installing ekctl..."
        brew install schappim/ekctl/ekctl
    else
        echo "⚠️  Skipping ekctl: requires the full Xcode app (not just Command Line Tools)."
        echo "   Install Xcode from the App Store, then run: brew install schappim/ekctl/ekctl"
    fi
fi

echo "🤖 Installing Claude skills..."

# QMD skill (bundled with the qmd CLI)
if command -v qmd >/dev/null 2>&1 && [[ ! -e "$HOME/.agents/skills/qmd" ]]; then
    qmd skill install --global --yes
fi

# ekctl skill (Calendar/Reminders), distributed as a Claude plugin marketplace
if command -v claude >/dev/null 2>&1; then
    claude plugin marketplace add schappim/ekctl-skill
    claude plugin install ekctl-skill@ekctl-skill
fi

echo "🔗 Installing dotfiles with stow..."

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
    echo "  Installing Homebrew packages from Brewfile..."
    HOMEBREW_BUNDLE_FILE_GLOBAL="$HOME/.config/homebrew/Brewfile" brew bundle install --global
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
